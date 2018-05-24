package LLVM;

import java.util.HashMap;
import java.util.List;

public class XORLLVMInstruction extends BinaryLLVMInstruction {

    public XORLLVMInstruction(String result, String type, String operand1, String operand2) {
        super(result, type, operand1, operand2);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = xor " + this.getType() + " " + this.getOperand1() + ", "
                + this.getOperand2() + "\n";
    }

    public List<String> toARM(HashMap<String, String> registerMap) {
        return super.toARM("eor", registerMap);
    }
}
