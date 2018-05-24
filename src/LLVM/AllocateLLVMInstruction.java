package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class AllocateLLVMInstruction extends ResultingLLVMInstruction {

    public AllocateLLVMInstruction(String result, String type) {
        super(result, type);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = alloca " + this.getType() + "\n";
    }

    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
        //TODO: verify allocate is the same as LLVM. I think we just return an empty list (for now).
        return instructions;
    }
}
