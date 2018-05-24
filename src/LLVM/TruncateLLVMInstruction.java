package LLVM;

import ARM.ARMInstruction;

import java.util.HashMap;
import java.util.List;

public class TruncateLLVMInstruction extends ResultingLLVMInstruction {

    private String oldType;
    private String value;

    public TruncateLLVMInstruction(String result, String oldType, String value, String newType) {
        super(result, newType);
        this.oldType = oldType;
        this.value = value;
    }

    @Override
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        System.out.println("TruncateLLVMInstruction toARM()");
        return null;
    }
}
