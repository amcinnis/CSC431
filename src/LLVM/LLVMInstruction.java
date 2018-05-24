package LLVM;

import ARM.ARMInstruction;

import java.util.HashMap;
import java.util.List;

public interface LLVMInstruction {
    List<ARMInstruction> toARM(HashMap<String, String> registerMap);
}
