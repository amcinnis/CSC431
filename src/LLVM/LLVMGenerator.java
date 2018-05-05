package LLVM;

import CFG.*;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class LLVMGenerator {

    FileWriter writer;
    List<String> visitedNodes;

    public LLVMGenerator(FileWriter writer) {
        this.writer = writer;
        this.visitedNodes = new ArrayList<>();
    }

    public void generate(ControlFlowGraph graph) {
        this.visitedNodes.add(((CFGNode)graph.entry).getLabel());
        printNode(graph.entry);
        visitedNodes.clear();
    }

    private void printNode(Node node) {
        if (node instanceof CFGNode) {
            CFGNode current = (CFGNode)node;
            printNodeLabel(current);
            printNodeLLVM(current.llvmInstructions);
            printNode(current.next);
        }
        else if (node instanceof ConditionalCFGNode) {
            ConditionalCFGNode current = (ConditionalCFGNode)node;
            printNodeLLVM(current.llvmInstructions);

            Node thenNode = current.thenNode;
            if (printNodeLabel(thenNode)) {
                printNode(thenNode);
            }

            if (current.elseNode != null) {
                Node elseNode = current.elseNode;
                if (printNodeLabel(elseNode)) {
                    printNode(elseNode);
                }
            }
        }
        else if (node instanceof WhileCFGNode) {
            WhileCFGNode current = (WhileCFGNode)node;

        }
    }

    private void printNodeLLVM(List<String> instructions) {
        try {
            for (String instruction : instructions) {
                System.out.print(instruction);
                this.writer.write(instruction);
            }
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    private boolean printNodeLabel(Node node) {
        if (node instanceof AbstractCFGNode) {
            AbstractCFGNode abstractCFGNode = (AbstractCFGNode)node;
            String label = abstractCFGNode.getLabel();
            if (this.visitedNodes.contains(label)) {
                return false;
            }
            else {
                try {
                    System.out.print(label + ":\n");
                    this.writer.write(label + ":\n");
                } catch (IOException e) {
                    e.printStackTrace();
                }
                this.visitedNodes.add(label);

                return true;
            }
        }
        else {
            System.out.println("Error! node not instanceof AbstractCFGNode in printNodeLabel!");

            return false;
        }
    }
}
