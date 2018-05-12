package CFG;

import LLVM.Instruction;

import java.util.ArrayList;
import java.util.List;

public abstract class AbstractCFGNode implements Node {

    private String label;
    public List<String> llvmStrings;
    public List <Instruction> llvmInstructions;

    public AbstractCFGNode(String label) {
        this.label = label;
        this.llvmInstructions = new ArrayList<>();
        this.llvmStrings = new ArrayList<>();
    }

    public String getLabel() {
        return label;
    }
}
