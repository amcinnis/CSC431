package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ReturnInstruction extends AbstractInstruction {

    private String type;
    private String value;

    public ReturnInstruction(String type, String value) {
        this.type = type;
        this.value = value;
    }

    @Override
    public String toString() {
        return "\tret " + type + " " + value + "\n";
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
        String armValue = armParamLookup(registerMap, this.value);
        instructions.add("\tmov r0, " + armValue + "\n");
//        instructions.add("\tret\n");
        return instructions;
    }
}
