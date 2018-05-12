package LLVM;

import CFG.*;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class LLVMGenerator {

    FileWriter writer;
    List<String> visitedNodes;
    CFGNode graphExit;
    boolean printExit;

    public LLVMGenerator(FileWriter writer) {
        this.writer = writer;
        this.visitedNodes = new ArrayList<>();
    }

    public void generate(ControlFlowGraph graph) {
        this.visitedNodes.add(((CFGNode)graph.entry).getLabel());
        this.graphExit = graph.exit;
        this.printExit = false;
        printNode(graph.entry);
        this.printExit = true;
        if (printNodeLabel(graphExit)) {
            printNode(graphExit);
        }
        visitedNodes.clear();
    }

    private void printNode(Node node) {
        if (node instanceof CFGNode) {
            CFGNode current = (CFGNode)node;
            if (current == graphExit && !this.printExit) { return; }
            printNodeLabel(current);
            printNodeLLVM(current.llvmStrings);
            printNode(current.next);
        }
        else if (node instanceof ConditionalCFGNode) {
            ConditionalCFGNode current = (ConditionalCFGNode)node;
            printNodeLLVM(current.llvmStrings);

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
            if (printNodeLabel(current)) {
                printNodeLLVM(current.llvmStrings);
            }

            Node body = current.body;
            if (printNodeLabel(body)) {
                printNode(body);
            }

            Node next = current.next;
            if (printNodeLabel(next)) {
                printNode(next);
            }
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
            if (abstractCFGNode == graphExit && !this.printExit) {
                return false;
            }
            String label = abstractCFGNode.getLabel();
            if (this.visitedNodes.contains(label)) {
                return false;
            }
            else {
                if (label.equals("Footer")) { return true; }
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

    public void printFooterInstructions() {
        CFGNode node = new CFGNode("Footer");
        node.llvmStrings.add("declare i8* @malloc(i32)\n");
        node.llvmStrings.add("declare void @free(i8*)\n");
        node.llvmStrings.add("declare i32 @printf(i8*, ...)\n");
        node.llvmStrings.add("declare i32 @scanf(i8*, ...)\n");
        node.llvmStrings.add("@.println = private unnamed_addr constant [5 x i8] c\"%ld\\0A\\00\", align 1\n");
        node.llvmStrings.add("@.print = private unnamed_addr constant [5 x i8] c\"%ld \\00\", align 1\n");
        node.llvmStrings.add("@.read = private unnamed_addr constant [4 x i8] c\"%ld\\00\", align 1\n");
        node.llvmStrings.add("@.read_scratch = common global i32 0, align 8\n");
        printNode(node);
    }
}
