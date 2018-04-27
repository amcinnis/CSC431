package CFG;

import ast.Expression;

public class WhileCFGNode extends AbstractCFGNode {

    private Expression guard;
    public Node body;
    public Node next;

    public WhileCFGNode(String label, Expression guard) {
        super(label);
        this.guard = guard;
    }
}
