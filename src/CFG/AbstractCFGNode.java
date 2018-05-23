package CFG;

import LLVM.Instruction;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public abstract class AbstractCFGNode implements Node {

    private String label;
    public Node pred0;
    public Node pred1;
    public List<Instruction> instructions;
    public List<String> llvmStrings;
    public List<String> armStrings;
    public HashSet<String> genSet;
    public HashSet<String> killSet;
    public HashSet<String> liveOut;

    public AbstractCFGNode(String label) {
        this.label = label;
        this.pred1 = null;
        this.pred0 = null;
        this.instructions = new ArrayList<>();
        this.llvmStrings = new ArrayList<>();
        this.armStrings = new ArrayList<>();
        this.genSet = new HashSet<>();
        this.killSet = new HashSet<>();
        this.liveOut = new HashSet<>();
    }

    public String getLabel() {
        return label;
    }

    @Override
    public String toString() {
        return this.label;
    }
}
