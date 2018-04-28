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
}
