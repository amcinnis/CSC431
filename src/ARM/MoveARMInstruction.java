package ARM;

public class MoveARMInstruction extends AbstractARMInstruction {

    private String code;
    private String operand1;
    private String operand2;

    public MoveARMInstruction(String operand1, String operand2) {
        this.code = null;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public MoveARMInstruction(String code, String operand1, String operand2) {
        this.code = code;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }
}
