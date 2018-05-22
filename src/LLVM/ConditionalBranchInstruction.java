package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ConditionalBranchInstruction extends AbstractInstruction {

    private String condition;
    private String thenLabel;
    private String elseLabel;

    public ConditionalBranchInstruction(String condition, String thenLabel, String elseLabel) {
        this.condition = condition;
        this.thenLabel = thenLabel;
        this.elseLabel = elseLabel;
    }

    @Override
    public String toString() {
        return "\tbr i1 " + condition + ", label %" + thenLabel + ", label %" + elseLabel + "\n";
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
        instructions.add("\tcmp " + this.condition + ", #1\n");
        instructions.add("\tbeq ." + this.thenLabel + "\n");
        instructions.add("\tb ." + this.elseLabel + "\n");
        return instructions;
    }
}
