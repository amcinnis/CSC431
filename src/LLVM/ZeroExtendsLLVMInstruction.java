package LLVM;

import java.util.HashMap;
import java.util.List;

public class ZeroExtendsLLVMInstruction extends ResultingLLVMInstruction {

    private String oldType;
    private String value;

    public ZeroExtendsLLVMInstruction(String result, String oldType, String value, String newType) {
        super(result, newType);
        this.oldType = oldType;
        this.value = value;
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = zext " + this.oldType + " " + this.value + " to "
                + this.getType() + "\n";
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        System.out.println("ZeroExtendsLLVMInstruction toARM()");
        return null;
    }
}
