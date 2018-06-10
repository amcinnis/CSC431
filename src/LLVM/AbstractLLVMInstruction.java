package LLVM;

import java.util.HashMap;

public abstract class AbstractLLVMInstruction implements LLVMInstruction {

    public boolean isInteger(String id) {
        boolean valid;
        try {
            Integer.parseInt(id);
            valid = true;
        }
        catch (NumberFormatException e) {
            valid = false;
        }
        return valid;
    }

    public String armParamLookup(HashMap<String, String> registerMap, String id) {
        if (registerMap.containsKey(id)) {
            return armParamLookup(registerMap, registerMap.get(id));
        }
        else {
            if (isInteger(id)) {
                return "#" + id;
            }
            else {
                return id;
            }
        }
    }
}
