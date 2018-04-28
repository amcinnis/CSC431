package LLVM;

public class BitcastInstruction extends ResultingInstruction {

    private String oldType;
    private String value;
    private String newType;

    public BitcastInstruction(String result, String oldType, String value, String newType) {
        super(result);
        this.oldType = oldType;
        this.value = value;
        this.newType = newType;
    }

}
