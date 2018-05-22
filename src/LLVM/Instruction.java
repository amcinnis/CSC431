package LLVM;

import java.util.HashMap;
import java.util.List;

public interface Instruction {
    List<String> toARM(HashMap<String, String> registerMap);
}
