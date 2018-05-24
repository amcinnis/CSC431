package LLVM;

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
    public List<String> toARM(HashMap<String, String> registerMap) {
        System.out.println("ImmediateLLVM.toARM() called!");
        return null;
    }
}
