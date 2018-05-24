package LLVM;

import ARM.ARMInstruction;
import ARM.BranchARMInstruction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class UnconditionalBranchLLVMInstruction extends AbstractLLVMInstruction {

    private String destination;

    public UnconditionalBranchLLVMInstruction(String destination) {
        this.destination = destination;
    }

    @Override
    public String toString() {
        return "\tbr label %" + destination + "\n";
    }

    @Override
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
//        instructions.add("\tb ." + this.destination + "\n");
        instructions.add(new BranchARMInstruction("." + this.destination));
        return instructions;
    }
}
