package LLVM;

import java.util.HashMap;
import java.util.List;

public interface LLVMInstruction {
    List<String> toARM(HashMap<String, String> registerMap);
}
