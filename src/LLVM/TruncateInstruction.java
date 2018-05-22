package LLVM;

import java.util.HashMap;
import java.util.List;

public class TruncateInstruction extends ResultingInstruction {

    private String oldType;
    private String value;

    public TruncateInstruction(String result, String oldType, String value, String newType) {
        super(result, newType);
        this.oldType = oldType;
        this.value = value;
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        System.out.println("TruncateInstruction toARM()");
        return null;
    }
}
