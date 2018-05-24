package LLVM;

import ARM.ARMInstruction;

import java.util.HashMap;
import java.util.List;

public class AddLLVMInstruction extends BinaryLLVMInstruction {

    public AddLLVMInstruction(String result, String type, String operand1, String operand2) {
        super(result, type, operand1, operand2);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = add " + this.getType() + " " + this.getOperand1() + ", "
                + this.getOperand2() + "\n";
    }

    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        return super.toARM("add", registerMap);
    }
}
