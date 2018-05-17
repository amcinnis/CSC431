package LLVM;

import java.util.ArrayList;
import java.util.List;

public class StoreInstruction extends AbstractInstruction {

    private String type;
    private String value;
    private String pointer;

    public StoreInstruction(String type, String value, String pointer) {
        this.type = type;
        this.value = value;
        this.pointer = pointer;
    }

    public String getType() {
        return type;
    }

    public String getValue() {
        return value;
    }

    public String getPointer() {
        return pointer;
    }

    @Override
    public String toString() {
        return "\tstore " + type + " " + value + ", " + type + "* " + pointer + "\n";
    }

    @Override
    public List<String> toARM() {
        List<String> instructions = new ArrayList<>();
        instructions.add("\tstr " + this.pointer + ", " + this.value + "\n");
        return instructions;
    }
}
