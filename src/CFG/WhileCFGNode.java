package CFG;

import LLVM.Instruction;
import ast.Expression;

import java.util.ArrayList;
import java.util.List;

public class WhileCFGNode extends AbstractCFGNode {

    private Expression guard;
    public List<Instruction> llvmInstructions;
    public List<String> llvmStrings;
    public Node body;
    public Node next;

    public WhileCFGNode(String label, Expression guard) {
        super(label);
        this.guard = guard;
        this.llvmInstructions = new ArrayList<>();
        this.llvmStrings = new ArrayList<>();
    }
}
