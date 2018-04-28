package LLVM;

public class CompareInstruction extends ResultingInstruction {

    private String conditionCode;
    private String type;
    private String operand1;
    private String operand2;

    public CompareInstruction(String result, String conditionCode,
                              String type, String operand1, String operand2) {
        super(result);
        this.conditionCode = conditionCode;
        this.type = type;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }
}
