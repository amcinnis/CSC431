package LLVM;

public class ZeroExtendsInstruction extends ResultingInstruction {

    private String oldType;
    private String value;

    public ZeroExtendsInstruction(String result, String oldType, String value, String newType) {
        super(result, newType);
        this.oldType = oldType;
        this.value = value;
    }
}
