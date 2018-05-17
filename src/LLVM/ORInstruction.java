package LLVM;

import java.util.List;

public class ORInstruction extends BinaryInstruction {

    public ORInstruction(String result, String type, String operand1, String operand2) {
        super(result, type, operand1, operand2);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = or " + this.getType() + " " + this.getOperand1() + ", "
                + this.getOperand2() + "\n";
    }

    public List<String> toARM() {
        return super.toARM("orr");
    }
}
