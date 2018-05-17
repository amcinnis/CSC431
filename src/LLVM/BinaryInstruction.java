package LLVM;

import java.util.ArrayList;
import java.util.List;

public abstract class BinaryInstruction extends ResultingInstruction {

    private String operand1;
    private String operand2;

    public BinaryInstruction(String result, String type, String operand1, String operand2) {
        super(result, type);
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public String getOperand1() {
        return operand1;
    }

    public String getOperand2() {
        return operand2;
    }

    public List<String> toARM(String op) {
        List<String> instructions = new ArrayList<>();
        if (this.getOperand2().matches("-?//d+")) {
            //TODO: Ask Keen about immediate bits. 12? 8?
            if (Integer.parseInt(this.getOperand2()) > Math.pow(2, 12)) {
                instructions.add("\tmovw t1, #lower16:" + getOperand2() +"\n");
                instructions.add("\tmovt t1, #upper16:" + getOperand2() + "\n");
                instructions.add("\t" + op + " " + this.getResult() + ", " + this.getOperand1() + ", t1\n");
            }
        }
        else {
            instructions.add("\t" + op + " " + this.getResult() + ", " + this.getOperand1() + ", " + this.getOperand2() + "\n");
        }

        return instructions;
    }
}
