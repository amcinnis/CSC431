package LLVM;

import java.util.List;

public class ANDInstruction extends BinaryInstruction {

    public ANDInstruction(String result, String type, String operand1, String operand2) {
        super(result, type, operand1, operand2);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = and " + this.getType() + " " + this.getOperand1() + ", "
                + this.getOperand2() + "\n";
    }

    @Override
    public List<String> toARM() {
        return super.toARM("and");
    }
}
