package ARM;

public class BranchARMInstruction extends AbstractARMInstruction {

    private String code;
    private String label;

    public BranchARMInstruction(String label) {
        this.label = label;
        this.code = null;
    }

    public BranchARMInstruction(String code, String label) {
        this.label = label;
        this.code = code;
    }

    @Override
    public String toString() {
        if (this.code == null) {
            return "\tb " + this.label + "\n";
        }
        else {
            return "\tb" + this.code + " " + this.label + "\n";
        }
    }
}
