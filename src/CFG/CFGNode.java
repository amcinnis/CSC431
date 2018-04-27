package CFG;

import java.util.ArrayList;
import java.util.List;

public class CFGNode extends AbstractCFGNode {

    public List <String> instructions;
    public Node next;

    public CFGNode(String label) {
        super(label);
        instructions = new ArrayList<String>();
    }
}
