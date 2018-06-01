package InterferenceGraph;

import ARM.*;
import CFG.*;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

public class InterferenceGraph {

    public HashMap<String, InterferenceNode> nodes;

    public InterferenceGraph() {
        this.nodes = new HashMap<>();
    }

    public void buildInterferenceGraph(List<Node> allNodes) {

        for (Node _node : allNodes) {
            if (_node instanceof AbstractCFGNode) {
                AbstractCFGNode node = (AbstractCFGNode)_node;
                HashSet<String> liveOut = node.liveOut;

                for (int i = node.ARMInstructions.size()-1; i >= 0; i--) {
                    ARMInstruction instruction = node.ARMInstructions.get(i);

                    if (instruction instanceof ARMString) { continue; }
                    else if (instruction instanceof BranchARMInstruction) { continue; }
                    else if (instruction instanceof PushARMInstruction) { continue; }
                    else if (instruction instanceof PopARMInstruction) { continue; }
                    else if (instruction instanceof BinaryARMInstruction) {
                        BinaryARMInstruction binary = (BinaryARMInstruction) instruction;
                        String target = binary.getTarget();
                        drawEdges(target, liveOut);
                        //Add each source to live set
                        String source1 = binary.getOperand1();
                        String source2 = binary.getOperand2();
                        liveOut.add(source1);
                        liveOut.add(source2);
                    }
                    else if (instruction instanceof CompareARMInstruction) {
                        CompareARMInstruction compare = (CompareARMInstruction)instruction;
                        //No target in compare, only add sources to live set.
                        String source1 = compare.getOperand1();
                        String source2 = compare.getOperand2();
                        liveOut.add(source1);
                        liveOut.add(source2);
                    }
                    else if (instruction instanceof LoadARMInstruction) {
                        LoadARMInstruction load = (LoadARMInstruction)instruction;
                        String target = load.getOperand1();
                        drawEdges(target, liveOut);
                        //Add each source to live set
                        String source = load.getOperand2();
                        liveOut.add(source);
                    }
                    else if (instruction instanceof StoreARMInstruction) {
                        StoreARMInstruction store = (StoreARMInstruction)instruction;
                        //No targets in store, only add sources to live set.
                        String source1 = store.getOperand1();
                        String source2 = store.getOperand2();
                        liveOut.add(source1);
                        liveOut.add(source2);
                    }
                    else if (instruction instanceof MoveARMInstruction) {
                        MoveARMInstruction move = (MoveARMInstruction)instruction;
                        String target = move.getOperand1();
                        drawEdges(target, liveOut);
                        //Add each source to live set
                        String source = move.getOperand2();
                        liveOut.add(source);
                    }
                    else {
                        System.out.println("Unimplemented instruction in buildInterferenceGraph!");
                    }
                }
            }
        }
    }

    private void drawEdges(String target, HashSet<String> liveOut) {
        //Remove target from live set
        liveOut.remove(target);
        //Check to see if target in graph. If not, add.
        if (!(this.nodes.containsKey(target))) {
            this.nodes.put(target, new InterferenceNode(target));
        }
        //Get target node
        InterferenceNode iNode = this.nodes.get(target);
        //Add edge from target to each element in live set.
        for (String reg : liveOut) {
            if (!(this.nodes.containsKey(reg))) {
                this.nodes.put(reg, new InterferenceNode(reg));
            }
            InterferenceNode element = this.nodes.get(reg);
            iNode.edges.add(element);
            element.edges.add(iNode);
        }
    }
}
