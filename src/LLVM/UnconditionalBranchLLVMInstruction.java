package LLVM;

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
    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
        instructions.add("\tb ." + this.destination + "\n");
        return instructions;
    }
}
