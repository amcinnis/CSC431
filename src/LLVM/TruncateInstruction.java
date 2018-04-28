package LLVM;

public class TruncateInstruction extends ResultingInstruction {

    private String oldType;
    private String value;
    private String newType;

    public TruncateInstruction(String result, String oldType, String value, String newType) {
        super(result);
        this.oldType = oldType;
        this.value = value;
        this.newType = newType;
    }
}
