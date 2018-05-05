package LLVM;

public class ReturnInstruction extends AbstractInstruction {

    private String type;
    private String value;

    public ReturnInstruction(String type, String value) {
        this.type = type;
        this.value = value;
    }

    @Override
    public String toString() {
        return "\tret " + type + " " + value + "\n";
    }
}
