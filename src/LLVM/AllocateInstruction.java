package LLVM;

import java.util.ArrayList;
import java.util.List;

public class AllocateInstruction extends ResultingInstruction {

    public AllocateInstruction(String result, String type) {
        super(result, type);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = alloca " + this.getType() + "\n";
    }

    public List<String> toARM() {
        List<String> instructions = new ArrayList<>();
        //TODO: verify allocate is the same as LLVM.
        return instructions;
    }
}
