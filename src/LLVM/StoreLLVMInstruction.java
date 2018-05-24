package LLVM;

import ARM.ARMInstruction;
import ARM.StoreARMInstruction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class StoreLLVMInstruction extends AbstractLLVMInstruction {

    private String type;
    private String value;
    private String pointer;

    public StoreLLVMInstruction(String type, String value, String pointer) {
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
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
        String armValue = armParamLookup(registerMap, this.value);
        String armPointer = armParamLookup(registerMap, this.pointer);
//        instructions.add("\tstr " + armValue + ", " + armPointer + "\n");
        instructions.add(new StoreARMInstruction(armValue, armPointer));
        return instructions;
    }
}
