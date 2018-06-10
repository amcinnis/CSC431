package LLVM;

import ARM.ARMInstruction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ImmediateLLVM extends AbstractLLVMInstruction {

    private String value;

    public ImmediateLLVM(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    @Override
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
//        System.out.println("ImmediateLLVM.toARM() called!");
        return instructions;
    }

    @Override
    public String toString() {
        return "";
    }
}
