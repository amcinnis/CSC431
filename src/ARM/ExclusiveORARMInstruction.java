package ARM;

public class ExclusiveORARMInstruction extends BinaryARMInstruction {

    public ExclusiveORARMInstruction(String target, String operand1, String operand2) {
        super(target, operand1, operand2);
    }

    @Override
    public String toString() {
        return this.getToString("eor");
    }
}
