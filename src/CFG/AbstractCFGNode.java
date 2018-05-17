package CFG;

import LLVM.Instruction;

import java.util.ArrayList;
import java.util.List;

public abstract class AbstractCFGNode implements Node {

    private String label;
    public List<String> llvmStrings;
    public List<Instruction> instructions;
    public List<String> armStrings;

    public AbstractCFGNode(String label) {
        this.label = label;
        this.instructions = new ArrayList<>();
        this.llvmStrings = new ArrayList<>();
        this.armStrings = new ArrayList<>();
    }

    public String getLabel() {
        return label;
    }
}
