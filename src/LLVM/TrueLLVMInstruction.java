package LLVM;

import ARM.ARMInstruction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class TrueLLVMInstruction implements LLVMInstruction{

    @Override
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
        return instructions;
    }

    @Override
    public String toString() {
        return "";
    }
}
