package ARM;

public class StoreARMInstruction extends AbstractARMInstruction {

    private String operand1;
    private String operand2;

    public StoreARMInstruction(String operand1, String operand2) {
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    @Override
    public String toString() {
        return "\tstr " + this.operand1 + ", " + this.operand2 + "\n";
    }
}
