package LLVM;

import ARM.ARMInstruction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ReturnVoidLLVMInstruction extends AbstractLLVMInstruction {

    public ReturnVoidLLVMInstruction() {

    }

    @Override
    public String toString() {
        return "\tret void\n";
    }

    @Override
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
//        instructions.add("\tret\n");
        return instructions;
    }
}
