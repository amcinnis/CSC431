package LLVM;

public class TruncateInstruction extends ResultingInstruction {

    private String oldType;
    private String value;

    public TruncateInstruction(String result, String oldType, String value, String newType) {
        super(result, newType);
        this.oldType = oldType;
        this.value = value;
    }
}
