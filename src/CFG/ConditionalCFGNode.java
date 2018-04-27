package CFG;

import ast.Expression;

public class ConditionalCFGNode extends AbstractCFGNode {

    private Expression guard;
    public Node thenNode;
    public Node elseNode;

    public ConditionalCFGNode(String label, Expression guard) {
        super(label);
        this.guard = guard;
    }
}
