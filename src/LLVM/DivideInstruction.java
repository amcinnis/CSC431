package LLVM;

import java.util.HashMap;
import java.util.List;

public class DivideInstruction extends BinaryInstruction {

    public DivideInstruction(String result, String type, String operand1, String operand2) {
        super(result, type, operand1, operand2);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = sdiv " + this.getType() + " " + this.getOperand1() + ", "
                + this.getOperand2() + "\n";
    }

    public List<String> toARM(HashMap<String, String> registerMap) {
        return super.toARM("sdiv", registerMap);
    }
}
