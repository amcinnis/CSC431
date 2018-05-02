package LLVM;

public class Immediate extends AbstractInstruction {

    private String value;

    public Immediate(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
