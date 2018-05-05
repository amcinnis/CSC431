package LLVM;

public class BitcastInstruction extends ResultingInstruction {

    private String oldType;
    private String value;

    public BitcastInstruction(String result, String oldType, String value, String newType) {
        super(result, newType);
        this.oldType = oldType;
        this.value = value;
    }

    public String getOldType() {
        return oldType;
    }

    public String getValue() {
        return value;
    }

    @Override
    public String toString() {
        return this.getResult() + " = bitcast " + oldType + " " + value + " to " + this.getType() + "\n";
    }
}
