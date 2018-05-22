package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class BitcastInstruction extends ResultingInstruction {

    private String oldType;
    private String value;

    public BitcastInstruction(String result, String oldType, String value, String newType) {
        super(result, newType);
        this.oldType = oldType;
        this.value = value;
    }

    public String getOldType() {
        return oldType;
    }

    public String getValue() {
        return value;
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = bitcast " + oldType + " " + value + " to " + this.getType() + "\n";
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
        instructions.add("\tmov " + this.getResult() + ", " + this.value + "\n");
        registerMap.put(this.value, this.getResult());
        return instructions;
    }
}
