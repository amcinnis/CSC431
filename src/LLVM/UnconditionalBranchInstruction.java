package LLVM;

import java.util.ArrayList;
import java.util.List;

public class UnconditionalBranchInstruction extends AbstractInstruction {

    private String destination;

    public UnconditionalBranchInstruction(String destination) {
        this.destination = destination;
    }

    @Override
    public String toString() {
        return "\tbr label %" + destination + "\n";
    }

    @Override
    public List<String> toARM() {
        List<String> instructions = new ArrayList<>();
        instructions.add("\tb ." + this.destination + "\n");
        return instructions;
    }
}
