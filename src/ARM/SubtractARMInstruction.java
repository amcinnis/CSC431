package ARM;

public class SubtractARMInstruction extends BinaryARMInstruction {

    public SubtractARMInstruction(String target, String operand1, String operand2) {
        super(target, operand1, operand2);
    }

    @Override
    public String toString() {
        return this.getToString("sub");
    }
}
