package LLVM;

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
}
