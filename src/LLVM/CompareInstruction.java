package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CompareInstruction extends ResultingInstruction {

    private String conditionCode;
    private String operand1;
    private String operand2;

    public CompareInstruction(String result, String conditionCode,
                              String type, String operand1, String operand2) {
        super(result, type);
        this.conditionCode = conditionCode;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    @Override
    public String toString() {
        return "\t" + getResult() + " = icmp " + conditionCode + " " + this.getType() + " " + operand1 + ", " + operand2 + "\n";
    }

    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
        instructions.add("\tmov " + this.getResult() + ", #0\n");
        String armOperand1 = armParamLookup(registerMap, this.operand1);
        String armOperand2 = armParamLookup(registerMap, this.operand2);
        instructions.add("\tcmp " + armOperand1 + ", " + armOperand2 + "\n");
        String movCode = null;
        switch (this.conditionCode) {
            case "eq":
                movCode = "eq";
                break;
            case "ne":
                movCode = "ne";
                break;
            case "sgt":
                movCode = "gt";
                break;
            case "sge":
                movCode = "ge";
                break;
            case "slt":
                movCode = "lt";
                break;
            case "sle":
                movCode = "le";
            default:
                System.out.println("Unimplemented conditionCode case in CompareInstruction toARM!");
                break;
        }
        instructions.add("\tmov" + movCode + " " + this.getResult() + ", #1\n");
        return instructions;
    }
}
