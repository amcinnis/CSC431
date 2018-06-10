package InterferenceGraph;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class InterferenceNode {

    public String registerName;
    public HashSet<InterferenceNode> edges;
    public String color;
    private ArrayList<String> availableColors;

    public InterferenceNode(String registerName) {
        this.registerName = registerName;
        this.edges = new HashSet<>();
        this.availableColors =
                Stream.of(/*"r0", "r1", "r2", "r3",*/ "r4", "r5", "r6", "r7", "r8")
                        .collect(Collectors.toCollection(ArrayList::new));
        if (this.availableColors.contains(this.registerName)
                || this.registerName.equals("r0") || this.registerName.equals("r1") || this.registerName.equals("r2")
                || this.registerName.equals("r3")) {
            this.color = this.registerName;
        }
        else {
            this.color = null;
        }
    }

    public void setColor() {
        if (this.color == null) {
            for (InterferenceNode edgeNode : edges) {
                this.availableColors.remove(edgeNode.color);
            }
            this.color = availableColors.get(0);
        }
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof InterferenceNode) {
            InterferenceNode node = (InterferenceNode)obj;
            return this.registerName.equals(node.registerName);
        }
        return false;
    }

    @Override
    public int hashCode() {
        return this.registerName.hashCode();
    }

    @Override
    public String toString() {
        return (this.registerName + "-> color: " + this.color + " numEdges: " + this.edges.size());
    }
}
