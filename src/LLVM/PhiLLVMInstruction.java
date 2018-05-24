package LLVM;

import java.util.HashMap;
import java.util.List;

public class PhiLLVMInstruction extends ResultingLLVMInstruction {

    public PhiLLVMInstruction(String result, String type) {
        super(result, type);
    }

    @Override
    public String toString() {
        return "PhiInstrucion toString";
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        System.out.println("PhiLLVMInstruction toARM()");
        return null;
    }
}
