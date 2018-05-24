package LLVM;

import ARM.ARMInstruction;
import ARM.LoadARMInstruction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class LoadLLVMInstruction extends ResultingLLVMInstruction {

    private String pointer;

    public LoadLLVMInstruction(String result, String type, String pointer) {
        super(result, type);
        this.pointer = pointer;
    }

    public String getPointer() {
        return pointer;
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = load " + this.getType() + " " + pointer + "\n";
    }

    @Override
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
        String armResult = armParamLookup(registerMap, this.getResult());
        String armPointer = armParamLookup(registerMap, this.getPointer());
//        instructions.add("\tldr " + armResult + ", " + armPointer + "\n");
        instructions.add(new LoadARMInstruction(armResult, armPointer));
//        registerMap.put(this.getResult(), this.pointer);
        return instructions;
    }
}
