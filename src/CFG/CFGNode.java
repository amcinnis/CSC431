package CFG;

import java.util.ArrayList;
import java.util.List;

public class CFGNode extends AbstractCFGNode {

    public List <String> miniStatements;
    public List <String> llvmInstructions;

    public Node next;

    public CFGNode(String label) {
        super(label);
        miniStatements = new ArrayList<>();
        llvmInstructions = new ArrayList<>();
    }
}
