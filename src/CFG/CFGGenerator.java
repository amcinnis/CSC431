package CFG;

import ast.*;

import java.util.ArrayList;
import java.util.List;

public class CFGGenerator {

    private Program program;
    private int labelCount;
    private int joinCount;
    private CFGNode graphEntry;

    public CFGGenerator(Program program) {
        this.program = program;
        this.labelCount = 1;
        this.joinCount = 1;
        this.graphEntry = null;
    }

    public List<ControlFlowGraph> generate() {
        List <ControlFlowGraph> graphs = new ArrayList<ControlFlowGraph>();

        //For each function in program, generate a CFG.
        for (Function function : program.getFuncs()) {
            graphs.add(generateCFG(function));
            graphEntry = null;
        }

        return graphs;
    }

    private ControlFlowGraph generateCFG(Function function) {
        String functionName = function.getName();
        ControlFlowGraph graph = new ControlFlowGraph(functionName);

        //Process Function Body
        BlockStatement body = (BlockStatement) function.getBody();
        List <Statement> statements = body.getStatements();

        //Check to see if need to build first CFGNode
        graphEntry = graph.entry;
        Node current = graph.entry;
//        current = checkForNewCFG(statements, current);

        //Iterate through all statements
        for (Statement statement : statements) {
            current = processStatement(statement, current);
        }

        if (current instanceof CFGNode) {
            ((CFGNode) current).next = new CFGNode("exit");
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
            ((CFGNode)current).instructions.add(instruction);
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
        //TODO: If nested nodes in block, which node is returned from processBlock?

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
}
