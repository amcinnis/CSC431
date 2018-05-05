package LLVM;

public class StoreInstruction extends AbstractInstruction {

    private String type;
    private String value;
    private String pointer;

    public StoreInstruction(String type, String value, String pointer) {
        this.type = type;
        this.value = value;
        this.pointer = pointer;
    }

    @Override
    public String toString() {
        return "store " + type + " " + value + ", " + type + "* " + "%" + pointer + "\n";
    }
}
