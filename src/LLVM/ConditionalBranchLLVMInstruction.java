package LLVM;

import ARM.ARMInstruction;
import ARM.BranchARMInstruction;
import ARM.CompareARMInstruction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ConditionalBranchLLVMInstruction extends AbstractLLVMInstruction {

    private String condition;
    private String thenLabel;
    private String elseLabel;

    public ConditionalBranchLLVMInstruction(String condition, String thenLabel, String elseLabel) {
        this.condition = condition;
        this.thenLabel = thenLabel;
        this.elseLabel = elseLabel;
    }

    @Override
    public String toString() {
        return "\tbr i1 " + condition + ", label %" + thenLabel + ", label %" + elseLabel + "\n";
    }

    @Override
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
//        instructions.add("\tcmp " + this.condition + ", #1\n");
        instructions.add(new CompareARMInstruction(this.condition, "#1"));
//        instructions.add("\tbeq ." + this.thenLabel + "\n");
        instructions.add(new BranchARMInstruction("eq", "." + this.thenLabel));
//        instructions.add("\tb ." + this.elseLabel + "\n");
        instructions.add(new BranchARMInstruction("." + this.elseLabel));
        return instructions;
    }
}
