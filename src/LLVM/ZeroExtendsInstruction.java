package LLVM;

public class ZeroExtendsInstruction extends ResultingInstruction {

    private String oldType;
    private String value;
    private String newType;

    public ZeroExtendsInstruction(String result, String oldType, String value, String newType) {
        super(result);
        this.oldType = oldType;
        this.value = value;
        this.newType = newType;
    }
}
