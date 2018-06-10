package InterferenceGraph;

import ARM.*;
import CFG.*;

import java.util.*;

public class InterferenceGraph {

    public HashMap<String, InterferenceNode> nodes;
    public HashMap<String, String> registerMap;
//    public List<InterferenceNode> spills;
    private HashSet<String> ignore;

    public InterferenceGraph() {
        this.nodes = new HashMap<>();
        this.registerMap = new HashMap<>();
//        this.spills = Arrays.asList(new InterferenceNode[2]);
        this.ignore = new HashSet<>();
        ignore.add("fp");
        ignore.add("sp");
        ignore.add("#");
        ignore.add("lr");
        ignore.add("pc");
    }

    public void buildInterferenceGraph(List<Node> allNodes) {
        constructGraph(allNodes);
        colorGraph();
    }

    private void constructGraph(List<Node> allNodes) {
        for (Node _node : allNodes) {
            if (_node instanceof AbstractCFGNode) {
                AbstractCFGNode node = (AbstractCFGNode)_node;
                HashSet<String> liveOut = node.liveOut;

                for (int i = node.ARMInstructions.size()-1; i >= 0; i--) {
                    ARMInstruction instruction = node.ARMInstructions.get(i);

                    if (instruction instanceof ARMString) { continue; }
                    else if (instruction instanceof PushARMInstruction) { continue; }
                    else if (instruction instanceof PopARMInstruction) { continue; }
                    else if (instruction instanceof BranchARMInstruction) {
                        BranchARMInstruction branch = (BranchARMInstruction)instruction;
                        if (branch.getCode() != null && branch.getCode().equals("l")) {
                            List<String> targets = branch.getTargets();
                            drawEdges(targets, liveOut);
                            List<String> sources = branch.getSources();
                            addSourcesToLiveOut(sources, liveOut);
                        }
                        continue;
                    }
                    else if (instruction instanceof BinaryARMInstruction) {
                        BinaryARMInstruction binary = (BinaryARMInstruction) instruction;
                        List<String> targets = binary.getTargets();
                        drawEdges(targets, liveOut);
                        //Add each source to live set
                        List<String> sources = binary.getSources();
                        addSourcesToLiveOut(sources, liveOut);
                    }
                    else if (instruction instanceof CompareARMInstruction) {
                        CompareARMInstruction compare = (CompareARMInstruction)instruction;
                        //No target in compare, only add sources to live set.
                        List<String> sources = compare.getSources();
                        addSourcesToLiveOut(sources, liveOut);
                    }
                    else if (instruction instanceof LoadARMInstruction) {
                        LoadARMInstruction load = (LoadARMInstruction)instruction;
                        List<String> targets = load.getTargets();
                        drawEdges(targets, liveOut);
                        //Add source to live set
                        List<String> source = load.getSources();
                        addSourcesToLiveOut(source, liveOut);
                    }
                    else if (instruction instanceof StoreARMInstruction) {
                        StoreARMInstruction store = (StoreARMInstruction)instruction;
                        //No targets in store, only add sources to live set.
                        List<String> sources = store.getSources();
                        addSourcesToLiveOut(sources, liveOut);
                    }
                    else if (instruction instanceof MoveARMInstruction) {
                        MoveARMInstruction move = (MoveARMInstruction)instruction;
                        List<String> targets = move.getTargets();
                        drawEdges(targets, liveOut);
                        //Add source to live set
                        List<String> source = move.getSources();
                        addSourcesToLiveOut(source, liveOut);
                    }
                    else {
                        System.out.println("Unimplemented instruction in buildInterferenceGraph!");
                    }
                }
            }
        }
    }

    private void drawEdges(List<String> targets, HashSet<String> liveOut) {
        for (String target : targets) {
            if (ignore.stream().parallel().noneMatch(targets::contains)) {
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
    }

    private void addSourcesToLiveOut(List<String> sources, HashSet<String> liveOut) {
        for (String source : sources) {
            if (ignore.stream().parallel().noneMatch(source::contains)) {
                liveOut.add(source);
            }
        }
    }

    private void colorGraph() {

        Stack<InterferenceNode> stack = new Stack<>();
        int numColors = this.nodes.size() - 2; //Save 2 for spills
//        int numColors = 5; //r4-r8

        //Deconstruct graph
        while (!(this.nodes.isEmpty())) {

            //Find node with least number of edges
            InterferenceNode leastEdgesNode = null;
            for (String nodeKey : this.nodes.keySet()) {
                InterferenceNode current = this.nodes.get(nodeKey);
                if (leastEdgesNode == null || current.edges.size() < leastEdgesNode.edges.size()) {
                    leastEdgesNode = current;
                }
            }

            //Remove edges to node being removed
            for (String nodeKey : this.nodes.keySet()) {
                //Iterate through nodes in graph
                InterferenceNode current = this.nodes.get(nodeKey);
                if (current.equals(leastEdgesNode)) {
                    //skip node being removed to preserve edges
                    continue;
                }
                //If connecting edge exists, removes edge to node being removed
                current.edges.remove(leastEdgesNode);
            }

            if (leastEdgesNode != null) {
                //Remove node from graph
                this.nodes.remove(leastEdgesNode.registerName);
                //Add node to stack
                stack.push(leastEdgesNode);
            }
            else {
                System.out.println("Error! Null leastEdgesNode in colorGraph()!");
            }
        }

        int spillCount = 0;
        //Re-populate graph and color nodes
        while (!(stack.isEmpty())) {
            InterferenceNode insert = stack.pop();
            if (this.nodes.size() < numColors) {
                insert.setColor();
                this.registerMap.put(insert.registerName, insert.color);
                this.nodes.put(insert.registerName, insert);
            }
            else {
                if (spillCount < 2) {
                    switch (spillCount) {
                        case 0:
                            insert.color = "r9";
                        case 1:
                            insert.color = "r10";
                    }
                    this.registerMap.put(insert.registerName, insert.color);
                    this.nodes.put(insert.registerName, insert);
                    spillCount++;
//                    spills.set(spillCount++, insert);
                }
                else {
                    System.out.println("Error! Graph has more than two spills in colorGraph()!");
                }
            }
        }
    }
}
