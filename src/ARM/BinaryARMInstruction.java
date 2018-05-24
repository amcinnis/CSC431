package ARM;

public class BinaryARMInstruction extends AbstractARMInstruction {

    private String target;
    private String operand1;
    private String operand2;

    public BinaryARMInstruction(String target, String operand1, String operand2) {
        this.target = target;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public String getToString(String op) {
        return "\t" + op + " " + target + ", " + this.operand1 + ", " + this.operand2 + "\n";
    }
}
