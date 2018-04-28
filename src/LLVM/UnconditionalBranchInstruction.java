package LLVM;

public class UnconditionalBranchInstruction extends AbstractInstruction {

    private String label;

    public UnconditionalBranchInstruction(String label) {
        this.label = label;
    }
}
