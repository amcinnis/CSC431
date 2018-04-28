package LLVM;

import java.util.List;

public class PhiInstruction extends ResultingInstruction {

    private String type;

    public PhiInstruction(String result, String type) {
        super(result);
        this.type = type;
    }
}
