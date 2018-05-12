package CFG;

import LLVM.Instruction;
import ast.Expression;

import java.util.ArrayList;
import java.util.List;

public class ConditionalCFGNode extends AbstractCFGNode {

    private Expression guard;
    public Node thenNode;
    public Node elseNode;

    public ConditionalCFGNode(String label, Expression guard) {
        super(label);
        this.guard = guard;
    }
}
