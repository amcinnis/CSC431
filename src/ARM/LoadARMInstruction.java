package ARM;

public class LoadARMInstruction extends AbstractARMInstruction {

    private String operand1;
    private String operand2;

    public LoadARMInstruction(String operand1, String operand2) {
        this.operand1 = operand1;
        this.operand2 = operand2;
    }
}