package LLVM;

public class BinaryInstruction extends ResultingInstruction {

    private String type;
    private String operand1;
    private String operand2;

    public BinaryInstruction(String result, String type, String operand1, String operand2) {
        super(result);
        this.type = type;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public String getType() {
        return type;
    }

    public String getOperand1() {
        return operand1;
    }

    public String getOperand2() {
        return operand2;
    }
}
