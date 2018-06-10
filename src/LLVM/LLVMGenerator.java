package LLVM;

import ARM.ARMInstruction;
import ARM.ARMString;
import CFG.*;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class LLVMGenerator {

    private FileWriter llvmWriter;
    private FileWriter armWriter;
    private List<String> visitedNodes;
    private CFGNode graphExit;
    private boolean printExit;
    private boolean stackOption;


    public LLVMGenerator(FileWriter llvmWriter, FileWriter armWriter, boolean stackOption) {
        this.llvmWriter = llvmWriter;
        this.armWriter = armWriter;
        this.visitedNodes = new ArrayList<>();
        this.stackOption = stackOption;
    }

    public void generate(ControlFlowGraph graph) {
        this.visitedNodes.add(graph.entry.getLabel());
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
            printNodeARM(current);
            Node _next = current.next;
            if (_next instanceof AbstractCFGNode) {
                AbstractCFGNode next = (AbstractCFGNode)_next;
                if (!(this.visitedNodes.contains(next.getLabel()))) {
                    printNode(next);
                }
            }
//            printNode(current.next);
        }
        else if (node instanceof ConditionalCFGNode) {
            ConditionalCFGNode current = (ConditionalCFGNode)node;
            printNodeLabel(current);
            printNodeLLVM(current.llvmStrings);
            printNodeARM(current);


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
                printNodeARM(current);
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
                if (stackOption) {
                    System.out.print(instruction);
                }
                this.llvmWriter.write(instruction);
            }
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void printNodeARM(AbstractCFGNode node) {
        try {
            for (ARMInstruction armInstruction : node.ARMInstructions) {
                System.out.print(armInstruction.toString());
                armWriter.write(armInstruction.toString());
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
            else if (abstractCFGNode.LLVMInstructions.size() == 0) {
                return false;
            }
            else {
                if (label.equals("Footer")) { return true; }
                try {
                    if (stackOption) {
                        System.out.print(label + ":\n");
                    }
                    this.llvmWriter.write(label + ":\n");
                    this.armWriter.write(label + ":\n");
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
        node.ARMInstructions.add(new ARMString("\t.section	.rodata\n"));
        node.ARMInstructions.add(new ARMString("\t.align\t2\n"));
        node.ARMInstructions.add(new ARMString(".PRINTLN_FMT:\n"));
        node.ARMInstructions.add(new ARMString("\t.asciz\t\"%ld\\n\"\n"));
        node.ARMInstructions.add(new ARMString("\t.align\t2\n"));
        node.ARMInstructions.add(new ARMString(".PRINT_FMT:\n"));
        node.ARMInstructions.add(new ARMString("\t.asciz\t\"%ld \"\n"));
        node.ARMInstructions.add(new ARMString("\t.align\t2\n"));
        node.ARMInstructions.add(new ARMString(".READ_FMT:\n"));
        node.ARMInstructions.add(new ARMString("\t.asciz\t\"%ld\"\n"));
        node.ARMInstructions.add(new ARMString("\t.comm\t.read_scratch,4,4\n"));
        node.ARMInstructions.add(new ARMString("\t.global __aeabi_idiv\n"));
        printNode(node);
    }
}
