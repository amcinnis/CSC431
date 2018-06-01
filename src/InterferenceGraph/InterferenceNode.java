package InterferenceGraph;

import java.util.HashSet;

public class InterferenceNode {

    public String registerName;
    public HashSet<InterferenceNode> edges;

    public InterferenceNode(String registerName) {
        this.registerName = registerName;
        this.edges = new HashSet<>();
    }

//    @Override
//    public boolean equals(Object obj) {
//        if (obj instanceof InterferenceNode) {
//            InterferenceNode node = (InterferenceNode)obj;
//            return this.registerName.equals(node.registerName);
//        }
//        return false;
//    }
//
//    @Override
//    public int hashCode() {
//        return this.registerName.hashCode();
//    }
}
