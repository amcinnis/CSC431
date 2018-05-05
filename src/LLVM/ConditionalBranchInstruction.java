package LLVM;

public class ConditionalBranchInstruction extends AbstractInstruction {

    private String condition;
    private String thenLabel;
    private String elseLabel;

    public ConditionalBranchInstruction(String condition, String thenLabel, String elseLabel) {
        this.condition = condition;
        this.thenLabel = thenLabel;
        this.elseLabel = elseLabel;
    }

    @Override
    public String toString() {
        return "br i1 " + condition + ", label " + thenLabel + ", label " + elseLabel + "\n";
    }
}
