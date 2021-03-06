package CFG;

import LLVM.*;
import ast.*;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.stream.Collectors;

public class CFGGenerator {

    private Program program;
    private int labelCount;
    private int joinCount;
    private int registerCount;
    private CFGNode graphEntry;
    private CFGNode graphExit;
    private List<String> globalLLVM;
    private List<String> globalARM;
    private Function currentFunction;
    private String inputFile;
    private FileWriter llvmWriter;
    private FileWriter armWriter;
    private boolean stackOption;
    private boolean regOff;
    private HashMap<String, String> registerMap;

    public CFGGenerator(String inputFile, Program program, boolean stackOption, boolean regOff) {
        this.program = program;
        this.labelCount = 0;
        this.joinCount = 0;
        this.registerCount = 0;
        this.graphEntry = null;
        this.graphExit = null;
        this.globalLLVM = new ArrayList<>();
        this.globalARM = new ArrayList<>();
        this.currentFunction = null;
        this.inputFile = inputFile;
        this.llvmWriter = null;
        this.armWriter = null;
        this.stackOption = stackOption;
        this.regOff = regOff;
        this.registerMap = new HashMap<>();
    }

    public void generate() {
        File llvmFile = createLLVMFile(inputFile);
        File armFile = createARMFile(llvmFile.getPath());
        try {
            llvmWriter = new FileWriter(llvmFile);
            armWriter = new FileWriter(armFile);
            List<ControlFlowGraph> graphs = new ArrayList<>();

            //Generate global miniStatements, write to file.
            List<TypeDeclaration> structs = program.getTypes();
            List<Declaration> globals = program.getDecls();
            generateGlobalInstructions(structs, globals);
            for (String globalInstruction : this.globalLLVM) {
                llvmWriter.write(globalInstruction);
            }
            for (String globalInstruction : this.globalARM) {
                armWriter.write(globalInstruction);
            }

//            int i = 0, funcStop = 6;
            //For each function in program, generate a CFG.
            for (Function function : program.getFuncs()) {
//                if (i == funcStop) { break; }
                this.currentFunction = function;
                graphs.add(generateCFG(function));
                graphEntry = null;
                graphExit = null;
//                i++;
            }

            //Print CFGs
            for (ControlFlowGraph graph : graphs) {
                graph.print();
            }

            //Write LLVM to file
            LLVMGenerator generator = new LLVMGenerator(llvmWriter, armWriter, stackOption);
            for (ControlFlowGraph graph : graphs) {
                generator.generate(graph);
            }

            //Footer Instructions
            generator.printFooterInstructions();

            llvmWriter.close();
            armWriter.close();
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    private File createLLVMFile(String inputFile) {
        //Get relative file path
        Path absolute = Paths.get(inputFile);
//        Path base = Paths.get("input");
        Path base = Paths.get("llvm_input");
        String relative = (base.relativize(absolute)).toString();

        //Strip extension and append "my"
        int pos = relative.lastIndexOf(".");
        String prefix = "out/my";
        String newExtension = ".ll";
        if (pos == -1) {
            return new File(prefix + relative + newExtension);
        }
        else {
            return new File(prefix + relative.substring(0, pos) + newExtension);
        }
    }

    private File createARMFile(String llvmPath) {
        //Strip extension and append '.s'
        int pos = llvmPath.lastIndexOf('.');
        String armExtension = ".s";
        if (pos == -1) {
            return new File(llvmPath + armExtension);
        }
        else {
            return new File(llvmPath.substring(0, pos) + armExtension);
        }
    }

    private void generateGlobalInstructions(List<TypeDeclaration> structs, List<Declaration> globals) {

        //Generate 32bit architecture instruction
        this.globalLLVM.add("target triple=\"i686\"\n");

        //ARM v7 Architecture
        this.globalARM.add("\t.arch armv7-a\n");

        //Generate struct definition miniStatements
        generateGlobalStructs(structs);
        this.globalLLVM.add("\n");

        //Generate global variable miniStatements
        generateGlobalDeclarations(globals);
        this.globalLLVM.add("\n");

        //ARM .text
        this.globalARM.add("\t.text\n\n");
    }

    private void generateGlobalStructs(List<TypeDeclaration> structs) {

        List<Declaration> fields;
        StringBuilder instruction;

        for (TypeDeclaration struct : structs) {
            instruction = new StringBuilder("%struct.");
            instruction.append(struct.getName() + " = type ");

            fields = struct.getFields();
            instruction.append("{");
            List<String> typesList = new ArrayList<>();
            for (Declaration field : fields) {
                Type type = field.getType();
                if (type instanceof IntType || type instanceof BoolType) {
                    typesList.add("i32");
                }
                else if (type instanceof StructType) {
                    String name = ((StructType) type).getName();
                    typesList.add("%struct." + name + "*");
                }
            }
            instruction.append(String.join(", ", typesList) + "}\n");
            this.globalLLVM.add(instruction.toString());
        }
    }

    private void generateGlobalDeclarations(List<Declaration> globals) {

        StringBuilder instruction;

        for (Declaration global : globals) {
            instruction = new StringBuilder("@");

            String name = global.getName();
            Type type = global.getType();
            if (type instanceof StructType) {
                String typeName = ((StructType) type).getName();
                instruction.append(name + " = common global %struct." + typeName + "* null, align 8\n");
            }
            //TODO: Make function more robust to handle Ints and Bools

            this.globalLLVM.add(instruction.toString());

            //ARM
            this.globalARM.add("\t.comm\t" + name + ",4,4\n");
        }
    }

    private ControlFlowGraph generateCFG(Function function) {
        String functionName = function.getName();
        ControlFlowGraph graph = new ControlFlowGraph(functionName);

        //Generate Entry and Exit nodes
        graphExit = new CFGNode(newLabel());
        graph.exit = graphExit;
        graph.entry = new CFGNode(newLabel());

        //Get function body
        BlockStatement body = (BlockStatement) function.getBody();
        List <Statement> statements = body.getStatements();

        //Create references to entry node
        graphEntry = graph.entry;
        Node current = graph.entry;

        //Generate function declaration in LLVM
        Type returnType = function.getRetType();
        List <Declaration> params = function.getParams();
        List <Declaration> locals = function.getLocals();
        StringBuilder declaration = new StringBuilder("define " + typeToLLVM(returnType) + " @");
        declaration.append(functionName + "(");

        //ARM Declaration
        graphEntry.armStrings.add("\t.align 2\n");
        graphEntry.armStrings.add("\t.global " + functionName + "\n");
        graphEntry.armStrings.add(functionName + ":\n");
        graphEntry.armStrings.add(graphEntry.getLabel() + ":\n");
        graphEntry.armStrings.add("\tpush {fp, lr}\n");
        graphEntry.armStrings.add("\tadd fp, sp, #4\n");

        //Generate LLVM/ARM for parameters
        List <String> llvmParams = new ArrayList<>();
        List <Instruction> allocateLLVM = new ArrayList<>();
        List <String> stackARM = new ArrayList<>();
        int armParamReg = 0, frameSize = 4 * (params.size() + locals.size()), paramOffset = 0;
        for (Declaration param : params) {
            Type paramType = param.getType();
            String name = param.getName();
            if (paramType instanceof IntType || paramType instanceof BoolType) {
                //LLVM
                llvmParams.add("i32 %" + name);
                AllocateInstruction paramAlloc = new AllocateInstruction("%_P_" + name, "i32");
                allocateLLVM.add(paramAlloc);
                StoreInstruction paramStore = new StoreInstruction("i32", "%" + name, "%_P_" + name);
//                registerMap.put(paramStore.getPointer(), paramStore.getValue());
                allocateLLVM.add(paramStore);

                //ARM
                //Map param name to respective register. For example:
                //func(i32 one, i32 two) -> key: one, value: r0; key: two, value: r1
//                this.registerMap.put(paramStore.getValue(), "r" + Integer.toString(armParamReg)); TODO: account for target register
                this.registerMap.put(paramStore.getPointer(), "[fp, #-" + Integer.toString(frameSize + paramOffset)
                        + "]");
                stackARM.addAll(paramStore.toARM(registerMap));
                //TODO: move outside of if statement to account for struct params
                armParamReg++;
                paramOffset += 4;

//                graphEntry.armStrings.add("\tmov %" + name + ", r" + armParamReg++ + "\n");

            }
            else if (paramType instanceof StructType) {
                //TODO: implement LLVM/ARM for struct params
                //LLVM
                StructType structType = (StructType)paramType;
                llvmParams.add("%struct." + structType.getName() + "* %" + name);
                System.out.println("Time to create alloca instructions for struct parameters!");

                //ARM
            }
        }
        declaration.append(String.join(", ", llvmParams) + ") ");

        //ARM stack setup for parameters
        List<String> reglist = null;
        if (armParamReg - 1 >= 4) {
            reglist = new ArrayList<>();
            for (int i = 4; i < armParamReg; i++) {
                reglist.add("r" + Integer.toString(i));
            }
            graphEntry.armStrings.add("\t push {" + String.join(", ", reglist) + "}\n");
        }

        //Add function declaration and opening brace to entry node
        graphEntry.llvmStrings.add(declaration.toString() + "\n");
        graphEntry.llvmStrings.add("{\n");
        graphEntry.llvmStrings.add(graphEntry.getLabel() + ":\n");


        //Generate LLVM for return type
        if (returnType instanceof VoidType) {
            ReturnVoidInstruction returnVoidInstruction = new ReturnVoidInstruction();
            graphExit.instructions.add(returnVoidInstruction);
            graphExit.llvmStrings.add(returnVoidInstruction.toString());
            graphExit.armStrings.addAll(returnVoidInstruction.toARM(registerMap));
        }
        else {
            //Allocate space on stack for return value
            String retTypeString = null;
            if (returnType instanceof IntType || returnType instanceof BoolType) {
                retTypeString = "i32";
            }
            else {
                retTypeString = "STRUCTTT";
            }
            AllocateInstruction returnAllocateInstruction = new AllocateInstruction("%_retval_", retTypeString);
            graphEntry.instructions.add(returnAllocateInstruction);
            graphEntry.llvmStrings.add(returnAllocateInstruction.toString());
            graphEntry.armStrings.addAll(returnAllocateInstruction.toARM(registerMap));
        }

        //Grab previously stored instructions and write them to entry node
        graphEntry.instructions.addAll(allocateLLVM);
        List<String> paramStrings = allocateLLVM.stream().map(Instruction::toString).collect(Collectors.toList());
        graphEntry.llvmStrings.addAll(paramStrings);
//        graphEntry.armStrings.addAll(allocateLLVM.stream().map(x -> x.toARM(registerMap)).flatMap(List::stream)
//                .collect(Collectors.toList()));

        //Generate LLVM for local variables
        Type localType;
        for (Declaration local : locals) {
            AllocateInstruction allocateInstruction = null;
            localType = local.getType();
            if (localType instanceof IntType || localType instanceof BoolType) {
                allocateInstruction = new AllocateInstruction("%" + local.getName(), "i32");
                this.registerMap.put(allocateInstruction.getResult(), "[fp, #-" + Integer.toString(frameSize + paramOffset)
                        + "]");
                paramOffset += 4;
            }
            else if (localType instanceof StructType) {
                StructType structType = (StructType)localType;
                allocateInstruction = new AllocateInstruction("%" + local.getName(),
                        "%struct." + structType.getName() + "*");
                this.registerMap.put(allocateInstruction.getResult(), "[fp, #-" + Integer.toString(frameSize + paramOffset)
                        + "]");
                paramOffset += 4;
            }
            else {
                System.out.println("Error! Reached VoidType when generating local variables LLVM!");
            }
            graphEntry.instructions.add(allocateInstruction);
            graphEntry.llvmStrings.add(allocateInstruction.toString());
            graphEntry.armStrings.addAll(allocateInstruction.toARM(registerMap));
        }

        //ARM stack setup for frame size (params and locals)
        graphEntry.armStrings.add("\tsub sp, sp, #" + Integer.toString(frameSize) + "\n");
        graphEntry.armStrings.addAll(stackARM);

        //Iterate through all statements
        for (Statement statement : statements) {
            current = processStatement(statement, current);
        }

        //Store return value to _retval_ if non-void function
        if (!(returnType instanceof VoidType)) {
            //Load return value in exit node
            LoadInstruction load = new LoadInstruction(newRegLabel(), typeToLLVM(returnType) + "*", "%_retval_");
//            registerMap.put(load.getResult(), load.getPointer());
            graphExit.instructions.add(load);
            graphExit.llvmStrings.add(load.toString());
            graphExit.armStrings.addAll(load.toARM(registerMap));
            //Strip tailing '*'
            String type = load.getType();
            if (type.equals("i32*")) {
                type = "i32";
            }
            ReturnInstruction ret = new ReturnInstruction(type, load.getResult());
            graphExit.instructions.add(ret);
            graphExit.llvmStrings.add(ret.toString());
            graphExit.armStrings.addAll(ret.toARM(registerMap));
        }


        if (current instanceof CFGNode) {
            CFGNode node = (CFGNode)current;
            if (node.instructions.size() > 0) {
                Instruction previous = node.instructions.get(node.instructions.size()-1);
                if (!(previous instanceof UnconditionalBranchInstruction || previous instanceof ConditionalBranchInstruction)) {
                    //Unconditional Branch to exit node
                    UnconditionalBranchInstruction finalBranch = new UnconditionalBranchInstruction(graphExit.getLabel());
                    node.instructions.add(finalBranch);
                    node.llvmStrings.add(finalBranch.toString());
                    node.armStrings.addAll(finalBranch.toARM(registerMap));
                }
            }

            node.next = graphExit;

        }
        else if (current instanceof WhileCFGNode) {
            WhileCFGNode whileNode = (WhileCFGNode)current;
            whileNode.next = graphExit;
            generateWhileBranches(whileNode);
        }

        graphExit.llvmStrings.add("}\n\n");
        if (reglist != null) {
            graphExit.armStrings.add("\tpop {" + String.join(", ", reglist) + "}\n");
        }
        graphExit.armStrings.add("\tadd sp, sp, #" + Integer.toString(frameSize) + "\n");
        graphExit.armStrings.add("\tpop {fp, pc}\n");
        graphExit.armStrings.add("\t.size " + functionName + ", .-" + functionName +"\n");

        return graph;
    }

    private Node processStatement(Statement statement, Node current) {
        if (statement instanceof BlockStatement) {
            BlockStatement block = (BlockStatement)statement;
            current = processBlock(block, current);
        }
        else if (statement instanceof ConditionalStatement) {
            ConditionalStatement conditional = (ConditionalStatement)statement;
            current = processConditional(conditional, current);

        }
        else if (statement instanceof WhileStatement) {
            WhileStatement whileStatement = (WhileStatement)statement;
            current = processWhile(whileStatement, current);
        }
        else {
            //check for graph.entry -> Create new node
            //check if CFGNode has been created. If not, create and link.
            if (current == null) {
                CFGNode newNode = new CFGNode(newLabel());
                current = newNode;
            }
            else if (current instanceof ConditionalCFGNode) {
                ConditionalCFGNode conditionalNode = (ConditionalCFGNode) current;
                if (conditionalNode.thenNode == null) {
                    CFGNode newNode = new CFGNode(newLabel());
                    conditionalNode.thenNode = newNode;
                    current = newNode;
                }
                else if (conditionalNode.elseNode == null) {
                    CFGNode newNode = new CFGNode(newLabel());
                    conditionalNode.elseNode = newNode;
                    current = newNode;
                }
                else {
                    System.out.println("processStatement conditionalNode's then/else both not null!");
                }
            }
            else if (current instanceof WhileCFGNode) {
                WhileCFGNode whileNode = (WhileCFGNode) current;
                CFGNode newNode = new CFGNode(newLabel());
                if (whileNode.body == null) {
                    whileNode.body = newNode;
                    current = newNode;
                }
                else if (whileNode.next == null) {
                    whileNode.next = newNode;
                    generateWhileBranches(whileNode);
                    current = newNode;
                }
                else {
                    System.out.println("processStatement whileNode's body/next both not null!");
                }
            }

            if (current instanceof CFGNode) {
                CFGNode currentNode = (CFGNode)current;
                //Get Statement
                String miniString = getInstruction(statement);
                //Store Mini Statement
                currentNode.miniStatements.add(miniString);
                //Generate LLVM for instruction
                List<Instruction> instructions = generateLLVMInstruction(statement);
                currentNode.instructions.addAll(instructions);
                List<String> llvmStrings = instructions.stream().map(Instruction::toString).collect(Collectors.toList());
                currentNode.llvmStrings.addAll(llvmStrings);
                currentNode.armStrings.addAll(instructions.stream().map(x -> x.toARM(registerMap)).flatMap(List::stream)
                        .collect(Collectors.toList()));
            }
        }

        return current;
    }

    private void generateWhileBranches(WhileCFGNode whileNode) {
        //WhileNode Guard
        ResultingInstruction result = (ResultingInstruction)whileNode.instructions.get(whileNode.instructions.size()-1);
        String bodyLabel = ((AbstractCFGNode)whileNode.body).getLabel();
        String nextLabel = ((AbstractCFGNode)whileNode.next).getLabel();
        ConditionalBranchInstruction branch =
                new ConditionalBranchInstruction(result.getResult(), bodyLabel, nextLabel);
        whileNode.instructions.add(branch);
        whileNode.llvmStrings.add(branch.toString());
        whileNode.armStrings.addAll(branch.toARM(registerMap));

        //Body CFGNode
        CFGNode body = (CFGNode)whileNode.body;
        result = (ResultingInstruction)body.instructions.get(body.instructions.size()-1);
        branch = new ConditionalBranchInstruction(result.getResult(), bodyLabel, nextLabel);
        body.instructions.add(branch);
        body.llvmStrings.add(branch.toString());
        body.armStrings.addAll(branch.toARM(registerMap));

    }

    private Node processConditional(ConditionalStatement conditional, Node current) {
        ConditionalCFGNode newNode = new ConditionalCFGNode(newLabel(), conditional.getGuard());

        //Guard LLVM
        List<Instruction> guardInstructions = generateLLVMFromExpression(conditional.getGuard());
        newNode.instructions.addAll(guardInstructions);
        List<String> guardStrings = guardInstructions.stream().map(Instruction::toString).collect(Collectors.toList());
        newNode.llvmStrings.addAll(guardStrings);
        newNode.armStrings.addAll(guardInstructions.stream().map(x -> x.toARM(registerMap)).flatMap(List::stream)
                .collect(Collectors.toList()));

        //CFG
        if (current instanceof CFGNode) {
            CFGNode cfgNode = (CFGNode)current;
            cfgNode.next = newNode;
            UnconditionalBranchInstruction branch = new UnconditionalBranchInstruction(newNode.getLabel());
            cfgNode.instructions.add(branch);
            cfgNode.llvmStrings.add(branch.toString());
            cfgNode.armStrings.addAll(branch.toARM(registerMap));
        }
        else if (current instanceof ConditionalCFGNode) {
            ConditionalCFGNode conditionalNode = (ConditionalCFGNode) current;
            if (conditionalNode.thenNode == null) {
                conditionalNode.thenNode = newNode;
            }
            else if (conditionalNode.elseNode == null) {
                conditionalNode.elseNode = newNode;
            }
            else {
                System.out.println("processConditional conditionalNode's then/else both not null!");
            }
        }
        else if (current instanceof WhileCFGNode) {
            WhileCFGNode whileNode = (WhileCFGNode) current;
            if (whileNode.body == null) {
                whileNode.body = newNode;
            }
            else if (whileNode.next == null) {
                whileNode.next = newNode;
                generateWhileBranches(whileNode);
            }
            else {
                System.out.println("processConditional whileNode's body/next both not null!");
            }
        }
        else {
            System.out.println("processConditional received unexpected Node as current");
        }

        BlockStatement thenBlock = (BlockStatement) conditional.getThenBlock();
        BlockStatement elseBlock = (BlockStatement) conditional.getElseBlock();

        //Traverse then block
        Node thenEnd = processBlock(thenBlock, newNode);

        //Traverse else block
        Node elseEnd = processBlock(elseBlock, newNode);

        //Join two blocks together
        CFGNode joinNode = new CFGNode(newJoinLabel());
        if (thenEnd instanceof CFGNode) {
            ((CFGNode) thenEnd).next = joinNode;
        }
        else {
            System.out.println("thenNode in conditional not instanceof CFGNode");
        }
        if (elseEnd instanceof CFGNode) {
            ((CFGNode) elseEnd).next = joinNode;
        }

        //Generate guard branch LLVM instruction
        CompareInstruction compareInstruction = (CompareInstruction)guardInstructions.get(guardInstructions.size()-1);
        String condition = compareInstruction.getResult();
        String thenLabel = ((AbstractCFGNode) newNode.thenNode).getLabel();
        String elseLabel = (newNode.elseNode != null) ?
                ((AbstractCFGNode) newNode.elseNode).getLabel() : joinNode.getLabel();
        ConditionalBranchInstruction branch = new ConditionalBranchInstruction(condition, thenLabel, elseLabel);
        newNode.instructions.add(branch);
        newNode.llvmStrings.add(branch.toString());
        newNode.armStrings.addAll(branch.toARM(registerMap));

        return joinNode;
    }

    private Node processWhile(WhileStatement whileStatement, Node current) {
        Expression guard = whileStatement.getGuard();
        WhileCFGNode newNode = new WhileCFGNode(newLabel(), guard);

        //Guard LLVM
        List<Instruction> guardInstructions = generateLLVMFromExpression(guard);
        List<String> guardStrings = guardInstructions.stream().map(Instruction::toString).collect(Collectors.toList());
        newNode.instructions.addAll(guardInstructions);
        newNode.llvmStrings.addAll(guardStrings);
        newNode.armStrings.addAll(guardInstructions.stream().map(x -> x.toARM(registerMap)).flatMap(List::stream)
                .collect(Collectors.toList()));

        if (current instanceof CFGNode) {
            CFGNode cfgNode = (CFGNode)current;
            UnconditionalBranchInstruction branch = new UnconditionalBranchInstruction(newNode.getLabel());
            cfgNode.instructions.add(branch);
            cfgNode.llvmStrings.add(branch.toString());
            cfgNode.armStrings.addAll(branch.toARM(registerMap));
            ((CFGNode) current).next = newNode;
        }
        else if (current instanceof ConditionalCFGNode) {
            ConditionalCFGNode conditionalNode = (ConditionalCFGNode) current;
            //TODO: Create Unconditional Branch?
            if (conditionalNode.thenNode == null) {
                conditionalNode.thenNode = newNode;
            }
            else if (conditionalNode.elseNode == null) {
                conditionalNode.elseNode = newNode;
            }
            else {
                System.out.println("processWhile conditional's then/else branches both full!");
            }
        }
        else if (current instanceof WhileCFGNode) {
            WhileCFGNode whileNode = (WhileCFGNode)current;
            //TODO: Create Unconditional Branch?
            whileNode.body = newNode;
        }
        else {
            System.out.println("processWhile received unexpected Node as current");
        }

        BlockStatement body = (BlockStatement) whileStatement.getBody();
        Node bodyEnd = processBlock(body, newNode);

        if (bodyEnd instanceof CFGNode) {
            CFGNode bodyNode = (CFGNode)bodyEnd;
            List<Instruction> bodyGuardInstructions = generateLLVMFromExpression(guard);
            List<String> bodyGuardStrings = bodyGuardInstructions.stream().map(Instruction::toString)
                    .collect(Collectors.toList());
            bodyNode.instructions.addAll(bodyGuardInstructions);
            bodyNode.llvmStrings.addAll(bodyGuardStrings);
            bodyNode.armStrings.addAll(bodyGuardInstructions.stream().map(x -> x.toARM(registerMap))
                    .flatMap(List::stream).collect(Collectors.toList()));
            bodyNode.next = newNode;
        }
        else {
            System.out.println("Body of while not instanceof CFGNode");
        }

        return newNode;
    }

    private Node processBlock(BlockStatement block, Node current) {
        List <Statement> statements = block.getStatements();
        if (statements.size() == 0) { return null; }

        for (Statement statement : statements) {
            current = processStatement(statement, current);
        }

        return current;
    }

    private List<Instruction> generateLLVMInstruction(Statement statement) {
        List<Instruction> instructions = new ArrayList<>();

        if (statement instanceof ReturnEmptyStatement) {
            UnconditionalBranchInstruction branch = new UnconditionalBranchInstruction(this.graphExit.getLabel());
            instructions.add(branch);
        }
        else if (statement instanceof ReturnStatement) {
            ReturnStatement returnStatement = (ReturnStatement)statement;
            Expression expression = returnStatement.getExpression();
            instructions = generateLLVMFromExpression(expression);

            String result;
            String type;
            Instruction prev = instructions.get(instructions.size()-1);
            if (!(prev instanceof Immediate)) {
                ResultingInstruction resultingInstruction =
                        (ResultingInstruction)prev;
                result = resultingInstruction.getResult();
                type = resultingInstruction.getType();
            }
            else {
                Immediate immediate = (Immediate)prev;
                result = immediate.getValue();
                type = "i32";
                instructions.remove(prev);
            }
            StoreInstruction storeResult = new StoreInstruction(type,
                    result, "%_retval_");
            registerMap.put(storeResult.getPointer(), storeResult.getValue());
            instructions.add(storeResult);

            //Generate UnconditionalBranch to graphExit
            UnconditionalBranchInstruction branch = new UnconditionalBranchInstruction(graphExit.getLabel());
            instructions.add(branch);
        }
        else if (statement instanceof AssignmentStatement) {
            AssignmentStatement assignmentStatement = (AssignmentStatement)statement;
            //Evaluate Assignment Source
            Expression source = assignmentStatement.getSource();
            Lvalue target = assignmentStatement.getTarget();
            ResultingInstruction sourceResult;
            if (!(source instanceof ReadExpression)) {
                if (source instanceof IntegerExpression) {
                    IntegerExpression integerExpression = (IntegerExpression) source;
                    sourceResult = new LoadInstruction(integerExpression.getValue(), "i32", null);
                } else {
                    List<Instruction> sourceInstructions = generateLLVMFromExpression(source);
                    instructions.addAll(sourceInstructions);
                    sourceResult = (ResultingInstruction) sourceInstructions.get(sourceInstructions.size() - 1);
                }

                String resultType = sourceResult.getType();
                if (resultType.equals("i32*")) {
                    resultType = "i32";
                }

                if (target instanceof LvalueId) {
                    LvalueId left = (LvalueId) target;
                    String id = storeIdentifierLookup(left.getId());
                    StoreInstruction storeInstruction = new StoreInstruction(resultType, sourceResult.getResult(), id);
                    instructions.add(storeInstruction);
                } else if (target instanceof LvalueDot) {
                    LvalueDot dotExpression = (LvalueDot) target;
                    List<Instruction> dotInstructions = processLvalueDotExpression(dotExpression);
                    instructions.addAll(dotInstructions);
                    ResultingInstruction dotResult = (ResultingInstruction) instructions.get(instructions.size() - 1);
                    StoreInstruction store = new StoreInstruction(resultType, sourceResult.getResult(), dotResult.getResult());
                    instructions.add(store);
                }
            }
            else {
                //ReadExpression
                List<String> args = new ArrayList<>();
                args.add("i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0)");
                if (target instanceof LvalueId) {
                    LvalueId value = (LvalueId)target;
                    args.add("i32* %" + value.getId());
                }
                CallInstruction call = new CallInstruction(null, "i32 (i8*, ...)*", "scanf", args);
                instructions.add(call);
            }
        }
        else if (statement instanceof InvocationStatement) {
            InvocationStatement invocation = (InvocationStatement)statement;
            Expression expression = invocation.getExpression();
            List<Instruction> invocationInstructions = generateLLVMFromExpression(expression);
            instructions.addAll(invocationInstructions);
        }
        else if (statement instanceof DeleteStatement) {
            DeleteStatement delete = (DeleteStatement)statement;
            Expression expression = delete.getExpression();
            List<Instruction> deleteInstructions = generateLLVMFromExpression(expression);
            instructions.addAll(deleteInstructions);
            LoadInstruction load = (LoadInstruction)deleteInstructions.get(deleteInstructions.size()-1);
            //Strip tailing '*'
            String type = load.getType();
            type = type.substring(0, type.length() - 1);
            BitcastInstruction bitcast = new BitcastInstruction(newRegLabel(), type, load.getResult(), "i8*");
            instructions.add(bitcast);
            List<String> functionArgs = new ArrayList<>();
            functionArgs.add(bitcast.getType() + " " + bitcast.getResult());
            CallInstruction call = new CallInstruction(null, "void", "free", functionArgs);
            instructions.add(call);
        }
        else if (statement instanceof PrintLnStatement) {
            PrintLnStatement printStatement = (PrintLnStatement) statement;
            Expression expression = printStatement.getExpression();
            List<Instruction> printInstructions = generateLLVMFromExpression(expression);
            instructions.addAll(printInstructions);
            List<String> args = new ArrayList<>();
            args.add("i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0)");
            ResultingInstruction result = (ResultingInstruction)printInstructions.get(printInstructions.size()-1);
            String type = result.getType();
            if (type.equals("i32*")) {
                type = type.substring(0, type.length() - 1);
            }
            args.add(type + " " + result.getResult());
            CallInstruction call = new CallInstruction(null, "i32 (i8*, ...)*", "printf", args);
            instructions.add(call);
        }
        else {
            System.out.println("generateLLVMInstruction encountered unaccounted for statement!");
            return null;
        }

        return instructions;
    }

    private List<Instruction> processLvalueDotExpression(LvalueDot dotExpression) {
        List<Instruction> instructions = new ArrayList<>();
        Expression left = dotExpression.getLeft();
        String structVariable = dotExpression.getId();
        return processDotHelper(left, instructions, structVariable);
    }

    private List<Instruction> processDotExpression(DotExpression dotExpression) {
        List<Instruction> instructions = new ArrayList<>();
        Expression left = dotExpression.getLeft();
        String structVariable = dotExpression.getId();
        instructions = processDotHelper(left, instructions, structVariable);
        ResultingInstruction resultingInstruction = (ResultingInstruction)instructions.get(instructions.size()-1);
        LoadInstruction loadResult = new LoadInstruction(newRegLabel(), "i32*", resultingInstruction.getResult());
        instructions.add(loadResult);

        return instructions;
    }

    private List<Instruction> processDotHelper(Expression left, List<Instruction> instructions, String structVariable) {
        if (left instanceof IdentifierExpression) {
            IdentifierExpression identifierExpression = (IdentifierExpression)left;
            String pointerName = identifierExpression.getId();
            LoadInstruction load = loadIdentifierLookup(pointerName);
            instructions.add(load);

            GetElementPtrInstruction get = generateGetElementPtr(load, structVariable);
            instructions.add(get);
        }
        else if (left instanceof DotExpression) {
            DotExpression dotExpression = (DotExpression)left;
            Expression nextLeft = dotExpression.getLeft();
            String rightId = dotExpression.getId();
            instructions = processDotHelper(nextLeft, instructions, rightId);

            GetElementPtrInstruction prevGet = (GetElementPtrInstruction) instructions.get(instructions.size()-1);
            String leftType = getStructTypeFromTypeString(prevGet.getType());
            Type rightType = null;
            List<TypeDeclaration> structs = this.program.getTypes();
            for (TypeDeclaration struct : structs) {
                if (struct.getName().equals(leftType)) {
                    List<Declaration> fields = struct.getFields();
                    for (Declaration field : fields) {
                        if (field.getName().equals(rightId)) {
                            rightType = field.getType();
                            break;
                        }
                    }
                }
                else if (rightType != null) { break; }
            }
            LoadInstruction load = new LoadInstruction(newRegLabel(), typeToLLVM(rightType) + "*", prevGet.getResult());
            instructions.add(load);

            GetElementPtrInstruction get = generateGetElementPtr(load, structVariable);
            instructions.add(get);
        }
        else {
            System.out.println("Unaccounted for Expression in processDotHelper!");
        }

        return instructions;
    }

    private GetElementPtrInstruction generateGetElementPtr(LoadInstruction previousLoad, String structVariable) {
        int fieldIndex = getFieldIndex(previousLoad, structVariable);
        //Strip tailing '*'
        String type = previousLoad.getType();
        type = type.substring(0, type.length() - 1);

        GetElementPtrInstruction get = new GetElementPtrInstruction(newRegLabel(), type,
                previousLoad.getResult(), Integer.toString(fieldIndex));
        return get;
    }

    private String getStructTypeFromTypeString(String typeString) {
        return typeString.substring(typeString.indexOf("%struct.") + 8, typeString.indexOf("*"));
    }

    private int getFieldIndex(LoadInstruction previousLoad, String structVariable) {
        List<TypeDeclaration> structs = this.program.getTypes();
        int fieldIndex = -1;

        String typeString = previousLoad.getType();
        String structName = getStructTypeFromTypeString(typeString);
        for (TypeDeclaration struct : structs) {
            if (struct.getName().equals(structName)) {
                fieldIndex = 0;
                List<Declaration> fields = struct.getFields();
                for (Declaration field : fields) {
                    if (field.getName().equals(structVariable)) {
                        return fieldIndex;
                    }
                    else {
                        fieldIndex++;
                    }
                }
            }
        }

        if (fieldIndex == -1) {
            System.out.println("Could not find struct in getFieldIndex! Returning -1");
        }
        else {
            System.out.println("Could not find variable in getFieldIndex! Returning false index.");
        }

        return fieldIndex;
    }

    private List<Instruction> generateLLVMFromExpression(Expression expression) {
        List<Instruction> instructions = new ArrayList<>();

        if (expression instanceof BinaryExpression) {
            BinaryExpression binaryExpression = (BinaryExpression)expression;
            Expression left = binaryExpression.getLeft();
            Expression right = binaryExpression.getRight();
            BinaryExpression.Operator operator = binaryExpression.getOperator();

            List<Instruction> leftInstructions = generateLLVMFromExpression(left);
            List<Instruction> rightInstructions = generateLLVMFromExpression(right);
            Instruction leftInstruction = leftInstructions.get(leftInstructions.size()-1);
            Instruction rightInstruction = rightInstructions.get(rightInstructions.size()-1);

            String operand1 = getOperandValue(leftInstruction);
            String operand2 = getOperandValue(rightInstruction);

            //Generate LLVM instructions
            if (!(leftInstruction instanceof Immediate)) {
                instructions.addAll(leftInstructions);
            }
            if (!(rightInstruction instanceof Immediate)) {
                instructions.addAll(rightInstructions);
            }

            Instruction opInstruction = generateBinaryOperatorLLVM(operator, operand1, operand2);
            instructions.add(opInstruction);
        }
        else if (expression instanceof NewExpression) {
            NewExpression newExpression = (NewExpression)expression;
            List<String> argsList = new ArrayList<>();
            String structId = newExpression.getId();
            argsList.add("i32 " + getStructSize(structId));
            CallInstruction callInstruction = new CallInstruction(newRegLabel(), "i8*",
                    "malloc", argsList);
            instructions.add(callInstruction);

            String oldType = callInstruction.getType();
            String value = callInstruction.getResult();
            String newType = "%struct." + structId + "*";
            BitcastInstruction bitcastInstruction = new BitcastInstruction(newRegLabel(), oldType, value, newType);
            instructions.add(bitcastInstruction);
        }
        else if (expression instanceof InvocationExpression) {
            InvocationExpression invocation = (InvocationExpression)expression;

            //Generate instructions for arguments
            List<Expression> arguments = invocation.getArguments();
            List<String> argsLLVM = new ArrayList<>();
            for (Expression argument : arguments) {
                List<Instruction> argumentLLVM = generateLLVMFromExpression(argument);
                Instruction paramInstruction = argumentLLVM.get(argumentLLVM.size() - 1);
                if (paramInstruction instanceof ResultingInstruction) {
                    ResultingInstruction result = (ResultingInstruction)paramInstruction;
                    String resultType = result.getType();
                    if (resultType.equals("i32*")) {
                        resultType = "i32";
                    }
                    argsLLVM.add(resultType + " " + result.getResult());
                }
                else if (paramInstruction instanceof Immediate){
                    Immediate result = (Immediate)paramInstruction;
                    argsLLVM.add("i32 " + result.getValue());
                    argumentLLVM.remove(paramInstruction);
                }
                else {
                    System.out.println("paramInstruction has unaccounted for Instance!");
                }
                instructions.addAll(argumentLLVM);
            }

            //Generate instructions for invocation
            Type returnType = getInvocationReturnType(invocation.getName());
            CallInstruction call;
            if (returnType instanceof VoidType) {
                call = new CallInstruction(null, "void", invocation.getName(), argsLLVM);
                instructions.add(call);
            }
            else if (returnType instanceof IntType || returnType instanceof BoolType) {
                call = new CallInstruction(newRegLabel(), typeToLLVM(returnType),
                        invocation.getName(), argsLLVM);
                instructions.add(call);
            }
            else if (returnType instanceof StructType) {
                System.out.println("Implement StructType for InvocationExpression in generateLLVMFromExpression");
            }
        }
        else if (expression instanceof IdentifierExpression) {
            IdentifierExpression identifierExpression = (IdentifierExpression)expression;
            LoadInstruction loadInstruction = loadIdentifierLookup(identifierExpression.getId());
            instructions.add(loadInstruction);
        }
        else if (expression instanceof IntegerExpression) {
            IntegerExpression integerExpression = (IntegerExpression)expression;
            instructions.add(new Immediate(integerExpression.getValue()));
        }
        else if (expression instanceof DotExpression) {
            DotExpression dotExpression = (DotExpression) expression;
            List<Instruction> dotInstructions = processDotExpression(dotExpression);
            instructions.addAll(dotInstructions);
        }
        else {
            System.out.println("generateLLVMFromExpression encountered Expression not yet accounted for!");
        }

        return instructions;
    }

    private String getStructSize(String id) {
        //Lookup struct to get size
        List<TypeDeclaration> structs = this.program.getTypes();

        for (TypeDeclaration struct : structs) {
            if (struct.getName().equals(id)) {
                return Integer.toString(struct.getFields().size() * 8);
            }
        }

        System.out.println("Error! Did not find struct when looking up in getStructSize");

        return null;
    }

    private Instruction generateBinaryOperatorLLVM(BinaryExpression.Operator operator, String operand1, String operand2) {
        Instruction instruction;

        switch (operator) {
            case LT:
            case GT:
            case LE:
            case GE:
            case EQ:
            case NE:
                //TODO: generate compare type for more than just Integer/Boolean
                instruction = new CompareInstruction(newRegLabel(), getConditionCode(operator),
                        "i32", operand1, operand2);
                break;
            case MINUS:
                instruction = new SubtractInstruction(newRegLabel(), "i32", operand1, operand2);
                break;
            case PLUS:
                instruction = new AddInstruction(newRegLabel(), "i32", operand1, operand2);
                break;
            case TIMES:
                instruction = new MultiplyInstruction(newRegLabel(), "i32", operand1, operand2);
                break;
            case DIVIDE:
                instruction = new DivideInstruction(newRegLabel(), "i32", operand1, operand2);
                break;
            default:
                System.out.println("Unaccounted for operator in generateBinaryOperatorLLVM!");
                instruction = null;
                break;
        }

        return instruction;
    }

    private Type getInvocationReturnType(String functionName) {
        List<Function> functions = this.program.getFuncs();
        for (Function function : functions) {
            if (function.getName().equals(functionName)) {
                return function.getRetType();
            }
        }

        System.out.println("Error! getInvocationReturnType did not find function '" + functionName + "'!");
        return null;
    }

    private String getConditionCode(BinaryExpression.Operator operator) {
        switch (operator) {
            case EQ: return "eq";
            case NE: return "ne";
            case GT: return "sgt";
            case GE: return "sge";
            case LT: return "slt";
            case LE: return "sle";
            default: System.out.println("Error! getConditionalCode found unaccounted for operator!");
                    return null;
        }
    }

    private String getOperandValue(Instruction instruction) {
        if (instruction instanceof ResultingInstruction) {
            ResultingInstruction resultingInstruction = (ResultingInstruction) instruction;
            return resultingInstruction.getResult();
        }
        else if (instruction instanceof Immediate) {
            Immediate immediate = (Immediate)instruction;
            return immediate.getValue();
        }
        else {
            System.out.println("Unaccounted for Instruction in getOperandValue!");
            return null;
        }
    }

    private String storeIdentifierLookup(String id) {
        //Check local scope
        List<Declaration> locals = currentFunction.getLocals();
        for (Declaration local : locals) {
            if (id.equals(local.getName())) {
                //TODO: Fix type pointer to also accomodate structs
                return "%" + id;
            }
        }

        //Check function parameters
        List<Declaration> params = currentFunction.getParams();
        for (Declaration param : params) {
            if (id.equals(param.getName())) {
                return "%_P_" + id;
            }
        }

        //Check global scope
        List<Declaration> globals = this.program.getDecls();
        for (Declaration global : globals) {
            if (id.equals(global.getName())) {
                return "@" + id;
            }
        }

        System.out.println("Error! Cannot lookup value of identifier '" + id + "' in storeIdentifierLookup!");

        return null;
    }

    private LoadInstruction loadIdentifierLookup(String id) {
        //Check local scope
        List<Declaration> locals = currentFunction.getLocals();
        for (Declaration local : locals) {
            if (id.equals(local.getName())) {
                Type type = local.getType();
                return new LoadInstruction(newRegLabel(), typeToLLVM(type) + "*", "%" + id);
            }
        }

        //Check function parameters
        List<Declaration> params = currentFunction.getParams();
        for (Declaration param : params) {
            if (id.equals(param.getName())) {
                Type type = param.getType();
                LoadInstruction load = new LoadInstruction(newRegLabel(), typeToLLVM(type) + "*",
                        "%_P_" + id);
//                registerMap.put(load.getResult(), load.getPointer());
                return load;
            }
        }

        //Check global scope
        List<Declaration> globals = this.program.getDecls();
        for (Declaration global : globals) {
            if (id.equals(global.getName())) {
                Type type = global.getType();
                return new LoadInstruction(newRegLabel(), typeToLLVM(type) + "*", "@" + id);
            }
        }

        System.out.println("Error! Cannot lookup value of identifier '" + id + "' in loadIdentifierLookup!");

        return null;
    }

    private String getInstruction(Statement statement) {
        if (statement instanceof BlockStatement) {
            return "Block Statement";
        }
        else if (statement instanceof DeleteStatement) {
            return "Delete Statement";
        }
        else if (statement instanceof InvocationStatement) {
            return "Invocation Statement";
        }
        else if (statement instanceof PrintLnStatement) {
            return "Println Statement";
        }
        else if (statement instanceof PrintStatement) {
            return "Print Statement";
        }
        else if (statement instanceof ReturnEmptyStatement) {
            return "Return Empty Statement";
        }
        else if (statement instanceof ReturnStatement) {
            return "Return Statement";
        }
        else if (statement instanceof AssignmentStatement) {
            return "Assignment Statement";
        }
        else {
            return "Other Statement";
        }
    }

    private String newLabel() {
        return "LU" + Integer.toString(labelCount++);
    }

    private String newJoinLabel() {
        return "JN" + Integer.toString(joinCount++);
    }

    private String newRegLabel() {
        return "%u" + Integer.toString(registerCount++);
    }

    private String typeToLLVM(Type type) {
        if (type instanceof IntType || type instanceof BoolType) {
            return "i32";
        }
        else if (type instanceof StructType) {
            return "%struct." + ((StructType) type).getName() + "*";
        }
        else if (type instanceof VoidType) {
            return "void";
        }
        else {
            System.out.println("typeToLLVM found type yet to be accounted for!");
            return null;
        }
    }
}
