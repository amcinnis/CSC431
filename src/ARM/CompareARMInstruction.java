package ARM;

public class CompareARMInstruction extends AbstractARMInstruction {

    private String operand1;
    private String operand2;

    public CompareARMInstruction(String operand1, String operand2) {
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public String getOperand1() {
        return operand1;
    }

    public String getOperand2() {
        return operand2;
    }

    @Override
    public String toString() {
        return "\tcmp " + this.operand1 + ", " + this.operand2 + "\n";
    }
}
