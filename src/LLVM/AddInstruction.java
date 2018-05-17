package LLVM;

import java.util.ArrayList;
import java.util.List;

public class AddInstruction extends BinaryInstruction {

    public AddInstruction(String result, String type, String operand1, String operand2) {
        super(result, type, operand1, operand2);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = add " + this.getType() + " " + this.getOperand1() + ", "
                + this.getOperand2() + "\n";
    }

    public List<String> toARM() {
        return super.toARM("add");
    }
}
