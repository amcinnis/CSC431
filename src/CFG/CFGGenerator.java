package CFG;

import LLVM.CompareInstruction;
import LLVM.Immediate;
import LLVM.Instruction;
import LLVM.LoadInstruction;
import ast.*;
import java.util.ArrayList;
import java.util.List;

public class CFGGenerator {

    private Program program;
    private int labelCount;
    private int joinCount;
    private int registerCount;
    private CFGNode graphEntry;
    private List<String> globalInstructions;
    private Function currentFunction;
    private List<String> allocationLLVM;

    public CFGGenerator(Program program) {
        this.program = program;
        this.labelCount = 0;
        this.joinCount = 0;
        this.registerCount = 0;
        this.graphEntry = null;
        this.globalInstructions = new ArrayList<>();
        this.currentFunction = null;
        this.allocationLLVM = new ArrayList<>();
    }

    public List<ControlFlowGraph> generate() {
        List <ControlFlowGraph> graphs = new ArrayList<>();

        //Generate global miniStatements
        List<TypeDeclaration> structs = program.getTypes();
        List<Declaration> globals = program.getDecls();
        generateGlobalInstructions(structs, globals);

        //For each function in program, generate a CFG.
        for (Function function : program.getFuncs()) {
            this.currentFunction = function;
            graphs.add(generateCFG(function));
            graphEntry = null;
            allocationLLVM.clear();
        }

        return graphs;
    }

    private void generateGlobalInstructions(List<TypeDeclaration> structs, List<Declaration> globals) {

        //Generate 32bit architecture instruction
        this.globalInstructions.add("target triple=\"i686\"");

        //Generate struct definition miniStatements
        generateGlobalStructs(structs);

        //Generate global variable miniStatements
        generateGlobalDeclarations(globals);
    }

    private void generateGlobalDeclarations(List<Declaration> globals) {

        StringBuilder instruction;

        for (Declaration global : globals) {
            instruction = new StringBuilder("@");

            String name = global.getName();
            Type type = global.getType();
            if (type instanceof StructType) {
                String typeName = ((StructType) type).getName();
                instruction.append(name + " = common global %struct." + typeName + "* null, align 8");
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
            instruction.append(String.join(", ", typesList) + "}");
            this.globalInstructions.add(instruction.toString());
        }
    }

    private ControlFlowGraph generateCFG(Function function) {
        String functionName = function.getName();
        ControlFlowGraph graph = new ControlFlowGraph(functionName);

        //Generate Entry and Exit nodes
        CFGNode exit = new CFGNode(newLabel());
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
                allocationLLVM.add("%_P_" + name + " = alloca i32");
                allocationLLVM.add("store i32 %" + name + ", i32* %_P_" + name);
            }
            else if (paramType instanceof StructType) {
                StructType structType = (StructType)paramType;
                llvmParams.add("%struct." + structType.getName() + "* %" + name);
                allocationLLVM.add("IMPLEMENT STRUCT ALLOCATION LLVM");
                allocationLLVM.add("IMPLEMENT STRUCT STORE LLVM");
            }
            //llvmParams.add(getLLVMType(paramType));
        }
        declaration.append(String.join(", ", llvmParams) + ") ");

        //Add function declaration and opening brace to entry node
        graphEntry.llvmInstructions.add(declaration.toString());
        graphEntry.llvmInstructions.add("{");

        //Generate LLVM for function params and locals
        List <Declaration> locals = function.getLocals();
        StringBuilder localInstruction;
        Type localType;
        for (Declaration local : locals) {
            localType = local.getType();
            localInstruction = new StringBuilder("%" + local.getName() + " = alloca ");
            if (localType instanceof IntType || localType instanceof BoolType) {
                localInstruction.append("i32");
            }
            else if (localType instanceof StructType) {
                StructType structType = (StructType)localType;
                localInstruction.append("%struct." + structType.getName() + "*");
            }
            allocationLLVM.add(localInstruction.toString());
        }
        graphEntry.llvmInstructions.addAll(allocationLLVM);

        //Iterate through all statements
        for (Statement statement : statements) {
            current = processStatement(statement, current);
        }

        if (current instanceof CFGNode) {
            ((CFGNode) current).next = exit;
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

            //add instruction to list
            //continue
            String instruction = getInstruction(statement);
            ((CFGNode)current).miniStatements.add(instruction);
        }

        return current;
    }

    private Node processConditional(ConditionalStatement conditional, Node current) {
        ConditionalCFGNode newNode = new ConditionalCFGNode(newLabel(), conditional.getGuard());

        if (current instanceof CFGNode) {
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

        return joinNode;
    }

    private Node processWhile(WhileStatement whileStatement, Node current) {
        WhileCFGNode newNode = new WhileCFGNode(newLabel(), whileStatement.getGuard());

        if (current instanceof CFGNode) {
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

    private List<String> generateConditionalLLVM(Expression guard) {
        List<String> instructions = new ArrayList<>();

        if (guard instanceof BinaryExpression) {
            BinaryExpression binaryExpression = (BinaryExpression)guard;
            Expression left = binaryExpression.getLeft();
            Expression right = binaryExpression.getRight();
            BinaryExpression.Operator operator = binaryExpression.getOperator();

            Instruction leftInstruction = getExpressionLLVM(left);
            Instruction rightInstruction = getExpressionLLVM(right);

            String operand1 = getOperandValue(leftInstruction);
            String operand2 = getOperandValue(rightInstruction);

            //TODO: edit return value of getOperandValue to include type for compare instruction
            CompareInstruction compare = new CompareInstruction(newRegLabel(), );

        }
        else if (guard instanceof TrueExpression) {

        }
        else if (guard instanceof FalseExpression) {

        }
        else {
            System.out.println("generateConditionalLLVM encountered guard not yet accounted for!");
        }

        return instructions;
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
            System.out.println("Encountered unaccounted for Expression in getEspressionLLVM!");
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

        System.out.println("Error! Cannot lookup value of identifier '" + id "'!");

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
            return "STRUCT?";
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
