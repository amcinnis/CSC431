package LLVM;

import java.util.HashMap;
import java.util.List;

public class Immediate extends AbstractInstruction {

    private String value;

    public Immediate(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        System.out.println("Immediate.toARM() called!");
        return null;
    }
}
