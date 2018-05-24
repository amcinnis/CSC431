package ARM;

public class ARMString extends AbstractARMInstruction {

    private String str;

    public ARMString(String str) {
        this.str = str;
    }

    @Override
    public String toString() {
        return str;
    }
}
