package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public abstract class BinaryLLVMInstruction extends ResultingLLVMInstruction {

    private String operand1;
    private String operand2;

    public BinaryLLVMInstruction(String result, String type, String operand1, String operand2) {
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

    public List<String> toARM(String op, HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
        if (isInteger(this.getOperand2()) && Math.abs(Integer.parseInt(this.getOperand2())) >= Math.pow(2, 8)) {
            instructions.add("\tmovw t1, #lower16:" + getOperand2() +"\n");
            instructions.add("\tmovt t1, #upper16:" + getOperand2() + "\n");
            instructions.add("\t" + op + " " + this.getResult() + ", " + this.getOperand1() + ", t1\n");
        }
        else {
            String armOperand1 = armParamLookup(registerMap, this.getOperand1());
            String armOperand2 = armParamLookup(registerMap, this.getOperand2());
            instructions.add("\t" + op + " " + this.getResult() + ", " + armOperand1 + ", " + armOperand2 + "\n");
        }

        return instructions;
    }
}
