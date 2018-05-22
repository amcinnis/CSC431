package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ReturnVoidInstruction extends AbstractInstruction {

    public ReturnVoidInstruction() {

    }

    @Override
    public String toString() {
        return "\tret void\n";
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
//        instructions.add("\tret\n");
        return instructions;
    }
}
