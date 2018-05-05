package CFG;

import LLVM.*;
import ast.*;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CFGGenerator {

    private Program program;
    private int labelCount;
    private int joinCount;
    private int registerCount;
    private CFGNode graphEntry;
    private CFGNode graphExit;
    private List<String> globalInstructions;
    private Function currentFunction;
    private List<String> allocationLLVM;
    private String inputFile;
    private FileWriter fileWriter;

    public CFGGenerator(String inputFile, Program program) {
        this.program = program;
        this.labelCount = 0;
        this.joinCount = 0;
        this.registerCount = 0;
        this.graphEntry = null;
        this.graphExit = null;
        this.globalInstructions = new ArrayList<>();
        this.currentFunction = null;
        this.allocationLLVM = new ArrayList<>();
        this.inputFile = inputFile;
        this.fileWriter = null;
    }

    public File generate() {
        File llvmFile = createLLVMFile(inputFile);
        try {
            fileWriter = new FileWriter(llvmFile);
            List<ControlFlowGraph> graphs = new ArrayList<>();

            //Generate global miniStatements, write to file.
            List<TypeDeclaration> structs = program.getTypes();
            List<Declaration> globals = program.getDecls();
            generateGlobalInstructions(structs, globals);
            for (String globalInstruction : this.globalInstructions) {
                fileWriter.write(globalInstruction);
            }

            //For each function in program, generate a CFG.
            for (Function function : program.getFuncs()) {
                this.currentFunction = function;
                graphs.add(generateCFG(function));
                graphEntry = null;
                allocationLLVM.clear();
            }

            //Print CFGs
            for (ControlFlowGraph graph : graphs) {
                graph.print();
            }

            //Write LLVM to file
            LLVMGenerator generator = new LLVMGenerator(fileWriter);
            for (ControlFlowGraph graph : graphs) {
                generator.generate(graph);
            }

            fileWriter.close();
        }
        catch (IOException e) {
            e.printStackTrace();
        }

        return llvmFile;
    }

    private File createLLVMFile(String inputFile) {
        //Get relative file path
        Path absolute = Paths.get(inputFile);
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

    private void generateGlobalInstructions(List<TypeDeclaration> structs, List<Declaration> globals) {

        //Generate 32bit architecture instruction
        this.globalInstructions.add("target triple=\"i686\"\n");

        //Generate struct definition miniStatements
        generateGlobalStructs(structs);
        this.globalInstructions.add("\n");

        //Generate global variable miniStatements
        generateGlobalDeclarations(globals);
        this.globalInstructions.add("\n");
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

            this.globalInstructions.add(instruction.toString());
        }
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
            this.globalInstructions.add(instruction.toString());
        }
    }

    private ControlFlowGraph generateCFG(Function function) {
        String functionName = function.getName();
        ControlFlowGraph graph = new ControlFlowGraph(functionName);

        //Generate Entry and Exit nodes
        graphExit = new CFGNode(newLabel());
        //Generate LLVM for return type
        Type returnType = function.getRetType();
        if (returnType instanceof VoidType) {
            ReturnVoidInstruction returnVoidInstruction = new ReturnVoidInstruction();
            graphExit.llvmInstructions.add(returnVoidInstruction.toString());
        }
        else {
            //Allocate space on stack for return value
        }
        graph.entry = new CFGNode(newLabel());

        //Get function body
        BlockStatement body = (BlockStatement) function.getBody();
        List <Statement> statements = body.getStatements();

        //Create references to entry node
        graphEntry = graph.entry;
        Node current = graph.entry;

        //Generate function declaration in LLVM
        List <Declaration> params = function.getParams();
        Type returnType = function.getRetType();
        StringBuilder declaration = new StringBuilder("define " + typeToLLVM(returnType) + " @");
        List <String> llvmParams = new ArrayList<>();

        declaration.append(functionName + "(");
        for (Declaration param : params) {
            Type paramType = param.getType();
            String name = param.getName();
            if (paramType instanceof IntType || paramType instanceof BoolType) {
                llvmParams.add("i32 %" + name);
                allocationLLVM.add("\t%_P_" + name + " = alloca i32\n");
                allocationLLVM.add("\tstore i32 %" + name + ", i32* %_P_" + name + "\n");
            }
            else if (paramType instanceof StructType) {
                StructType structType = (StructType)paramType;
                llvmParams.add("%struct." + structType.getName() + "* %" + name);
                allocationLLVM.add("IMPLEMENT STRUCT ALLOCATION LLVM");
                allocationLLVM.add("IMPLEMENT STRUCT STORE LLVM");
            }
        }
        declaration.append(String.join(", ", llvmParams) + ") ");

        //Add function declaration and opening brace to entry node
        graphEntry.llvmInstructions.add(declaration.toString() + "\n");
        graphEntry.llvmInstructions.add("{\n");
        graphEntry.llvmInstructions.add(graphEntry.getLabel() + ":\n");

        //Generate LLVM for function params and locals
        List <Declaration> locals = function.getLocals();
        StringBuilder localInstruction;
        Type localType;
        for (Declaration local : locals) {
            localType = local.getType();
            localInstruction = new StringBuilder("\t%" + local.getName() + " = alloca ");
            if (localType instanceof IntType || localType instanceof BoolType) {
                localInstruction.append("i32");
            }
            else if (localType instanceof StructType) {
                StructType structType = (StructType)localType;
                localInstruction.append("%struct." + structType.getName() + "*");
            }
            allocationLLVM.add(localInstruction.toString() + "\n");
        }
        graphEntry.llvmInstructions.addAll(allocationLLVM);

        //Iterate through all statements
        for (Statement statement : statements) {
            current = processStatement(statement, current);
        }

        //Unconditional Branch to exit node
        UnconditionalBranchInstruction finalBranch = new UnconditionalBranchInstruction(graphExit.getLabel());
        ((CFGNode)current).llvmInstructions.add(finalBranch.toString());

        if (current instanceof CFGNode) {
            ((CFGNode) current).next = graphExit;
            graphExit.llvmInstructions.add("}\n");
        }

        return graph;
    }

    private Node processStatement(Statement statement, Node current) {
        if (statement instanceof BlockStatement) {
            BlockStatement block = (BlockStatement)statement;
            current = processBlock(block, current);
        }
        else if (statement instanceof ConditionalStatement) {
            ConditionalStatement conditional = (ConditionalStatement)statement;
            //Create new ConditionalCFGNode
            //current.next = new Conditional Node
            current = processConditional(conditional, current);

        }
        else if (statement instanceof WhileStatement) {
            WhileStatement whileStatement = (WhileStatement)statement;
            //Create new WhileCFGNode
            //current.next = new While node
            current = processWhile(whileStatement, current);
        }
        else {
            //check for graph.entry -> Create new node
            //check if CFGNode has been created. If not, create and link.
            if (current == graphEntry || current == null) {
                CFGNode newNode = new CFGNode(newLabel());

                if (current == graphEntry) {
                    graphEntry.next = newNode;
                }
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
                    current = newNode;
                }
                else {
                    System.out.println("processStatement whileNode's body/next both not null!");
                }
            }

            //Get Statement
            String miniString = getInstruction(statement);
            //Store Mini Statement
            ((CFGNode)current).miniStatements.add(miniString);
            //Generate LLVM for instruction
            List<Instruction> instructions = generateLLVMInstruction(statement);
            List<String> llvmStrings = instructions.stream().map(Instruction::toString).collect(Collectors.toList());
            ((CFGNode)current).llvmInstructions.addAll(llvmStrings);
        }

        return current;
    }

    private Node processConditional(ConditionalStatement conditional, Node current) {
        ConditionalCFGNode newNode = new ConditionalCFGNode(newLabel(), conditional.getGuard());

        //Guard LLVM
        List<Instruction> guardLLVM = generateLLVMFromExpression(conditional.getGuard());
        List<String> guardStrings = guardLLVM.stream().map(Instruction::toString).collect(Collectors.toList());
        newNode.llvmInstructions.addAll(guardStrings);

        //CFG
        if (current instanceof CFGNode) {
            CFGNode cfgNode = (CFGNode)current;
            cfgNode.next = newNode;
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
        CompareInstruction compareInstruction = (CompareInstruction)guardLLVM.get(guardLLVM.size()-1);
        String condition = compareInstruction.getResult();
        String thenLabel = ((AbstractCFGNode) newNode.thenNode).getLabel();
        String elseLabel = (newNode.elseNode != null) ?
                ((AbstractCFGNode) newNode.elseNode).getLabel() : joinNode.getLabel();
        ConditionalBranchInstruction branch = new ConditionalBranchInstruction(condition, thenLabel, elseLabel);
        newNode.llvmInstructions.add(branch.toString());

        return joinNode;
    }

    private Node processWhile(WhileStatement whileStatement, Node current) {
        WhileCFGNode newNode = new WhileCFGNode(newLabel(), whileStatement.getGuard());

        if (current instanceof CFGNode) {
            CFGNode cfgNode = (CFGNode)current;
            ((CFGNode) current).next = newNode;
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
                System.out.println("processWhile conditional's then/else branches both full!");
            }
        }
        else if (current instanceof WhileCFGNode) {
            ((WhileCFGNode) current).body = newNode;
        }
        else {
            System.out.println("processWhile received unexpected Node as current");
        }

        BlockStatement body = (BlockStatement) whileStatement.getBody();
        Node bodyEnd = processBlock(body, newNode);
        if (bodyEnd instanceof CFGNode) {
            ((CFGNode) bodyEnd).next = newNode;
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
        else if (statement instanceof AssignmentStatement) {
            AssignmentStatement assignmentStatement = (AssignmentStatement)statement;
            //Evaluate Assignment Source
            Expression source = assignmentStatement.getSource();
            List<Instruction> sourceInstructions = generateLLVMFromExpression(source);
            instructions.addAll(sourceInstructions);

            Lvalue target = assignmentStatement.getTarget();
            if (target instanceof LvalueId) {
                LvalueId left = (LvalueId)target;
                BitcastInstruction bitcast = (BitcastInstruction)sourceInstructions.get(sourceInstructions.size() - 1);
                StoreInstruction storeInstruction = new StoreInstruction(bitcast.getType(), bitcast.getResult(), left.getId());
                instructions.add(storeInstruction);
            }
        }
        else if (statement instanceof InvocationStatement) {
            InvocationStatement invocation = (InvocationStatement)statement;
            Expression expression = invocation.getExpression();
            List<Instruction> invocationInstructions = generateLLVMFromExpression(expression);
            instructions.addAll(invocationInstructions);
        }
        else {
            System.out.println("generateLLVMInstruction encountered unaccounted for statement!");
            return null;
        }

        return instructions;
    }

    private List<Instruction> generateLLVMFromExpression(Expression expression) {
        List<Instruction> instructions = new ArrayList<>();

        if (expression instanceof BinaryExpression) {
            BinaryExpression binaryExpression = (BinaryExpression)expression;
            Expression left = binaryExpression.getLeft();
            Expression right = binaryExpression.getRight();
            BinaryExpression.Operator operator = binaryExpression.getOperator();

            Instruction leftInstruction = getExpressionLLVM(left);
            Instruction rightInstruction = getExpressionLLVM(right);

            String operand1 = getOperandValue(leftInstruction);
            String operand2 = getOperandValue(rightInstruction);

            //Generate LLVM instructions
            if (leftInstruction instanceof LoadInstruction) {
                LoadInstruction loadInstruction = (LoadInstruction)leftInstruction;
                instructions.add(loadInstruction);
            }
            if (rightInstruction instanceof LoadInstruction) {
                LoadInstruction loadInstruction = (LoadInstruction)rightInstruction;
                instructions.add(loadInstruction);
            }

            Instruction opInstruction = generateBinaryOperatorLLVM(operator, operand1, operand2);
            instructions.add(opInstruction);
        }
        else if (expression instanceof NewExpression) {
            NewExpression newExpression = (NewExpression)expression;
            List<String> argsList = new ArrayList<>();
            argsList.add("i32 24");
            CallInstruction callInstruction = new CallInstruction(newRegLabel(), "i8*",
                    "@malloc", argsList);
            instructions.add(callInstruction);

            String oldType = callInstruction.getType();
            String value = callInstruction.getResult();
            String newType = "%struct." + newExpression.getId() + "*";
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
                instructions.addAll(argumentLLVM);
                ResultingInstruction result = (ResultingInstruction)argumentLLVM.get(argumentLLVM.size() - 1);
                argsLLVM.add(result.getType() + " " + result.getResult());
            }

            //Generate instructions for invocation
            Type returnType = getInvocationReturnType(invocation.getName());
            CallInstruction call;
            if (returnType instanceof VoidType) {
                call = new CallInstruction(null, "void", "@"+invocation.getName(), argsLLVM);
                instructions.add(call);
            }
            else if (returnType instanceof IntType || returnType instanceof BoolType) {
                System.out.println("Implement IntType/BoolType for InvocationExpression in generateLLVMFromExpression");
            }
            else if (returnType instanceof StructType) {
                System.out.println("Implement StructType for InvocationExpression in generateLLVMFromExpression");
            }
        }
        else {
            System.out.println("generateLLVMFromExpression encountered Expression not yet accounted for!");
        }

        return instructions;
    }

    private Instruction generateBinaryOperatorLLVM(BinaryExpression.Operator operator, String operand1, String operand2) {
        Instruction instruction;

        switch (operator) {
            case LT:
            case GT:
            case LE:
            case GE:
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

    private Instruction getExpressionLLVM(Expression expression) {

        if (expression instanceof IdentifierExpression) {
            IdentifierExpression identifierExpression = (IdentifierExpression)expression;
            String id = identifierExpression.getId();
            return identifierLookup(id);
        }
        else if (expression instanceof IntegerExpression) {
            IntegerExpression integerExpression = (IntegerExpression)expression;
            return new Immediate(integerExpression.getValue());
        }
        else {
            System.out.println("Encountered unaccounted for Expression in getExpressionLLVM!");
            return null;
        }
    }

    private String getOperandValue(Instruction instruction) {
        if (instruction instanceof LoadInstruction) {
            LoadInstruction loadInstruction = (LoadInstruction)instruction;
            return loadInstruction.getResult();
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

    private LoadInstruction identifierLookup(String id) {
        //Check local scope
        List<Declaration> locals = currentFunction.getLocals();
        for (Declaration local : locals) {
            if (id.equals(local.getName())) {
                Type type = local.getType();
                //TODO: Fix type pointer to also accomodate structs
                return new LoadInstruction(newRegLabel(), typeToLLVM(type) + "*", "%" + id);
            }
        }

        //Check function parameters
        List<Declaration> params = currentFunction.getParams();
        for (Declaration param : params) {
            if (id.equals(param.getName())) {
                Type type = param.getType();
                return new LoadInstruction(newRegLabel(), typeToLLVM(type) + "*", "%_P_" + id);
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

        System.out.println("Error! Cannot lookup value of identifier '" + id + "'!");

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
            //TODO: include struct name in return
            return "%struct.";
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
