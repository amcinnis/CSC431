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

    public String getType() {
        return type;
    }

    public String getValue() {
        return value;
    }

    public String getPointer() {
        return pointer;
    }

    @Override
    public String toString() {
        return "\tstore " + type + " " + value + ", " + type + "* " + pointer + "\n";
    }
}
