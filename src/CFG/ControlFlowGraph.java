package CFG;

import java.util.ArrayList;
import java.util.List;

public class ControlFlowGraph {

    private String functionName;
    public CFGNode entry;
    public CFGNode exit;

    public ControlFlowGraph(String functionName) {
        this.functionName = functionName;
    }

    public void print() {
        List<String> whileLabels= new ArrayList<String>();

        System.out.println("Control Flow graph for function " + functionName + ":");
        System.out.println();
        print(entry, whileLabels);
        System.out.println();
        System.out.println("End Control Flow Graph for function " + functionName);
    }

    private void print(Node current, List whileLabels) {

        if (current instanceof CFGNode) {
            CFGNode node = (CFGNode) current;
            String label = node.getLabel();
            System.out.println(label);
            print(node.next, whileLabels);
        }
        else if (current instanceof ConditionalCFGNode) {
            ConditionalCFGNode conditionalNode = (ConditionalCFGNode) current;
            System.out.println(conditionalNode.getLabel());
            System.out.print(conditionalNode.getLabel() + " Then: ");
            print(conditionalNode.thenNode, whileLabels);
            if (conditionalNode.elseNode != null) {
                System.out.print(conditionalNode.getLabel() + " Else: ");
                print(conditionalNode.elseNode, whileLabels);
            }
        }
        else if (current instanceof WhileCFGNode) {
            WhileCFGNode whileNode = (WhileCFGNode) current;
            String label = whileNode.getLabel();
            System.out.println(label);
            if (!(whileLabels.contains(label))) {
                if (whileNode.body instanceof AbstractCFGNode) {
                    System.out.println(label + " Body: " + ((AbstractCFGNode) whileNode.body).getLabel());
                    whileLabels.add(label);
                    print(whileNode.body, whileLabels);
                }
            }
            else {
                whileLabels.remove(label);
                System.out.print(whileNode.getLabel() + " next: ");
                print(whileNode.next, whileLabels);
            }
        }
    }

}
