package LLVM;

public class LoadInstruction extends ResultingInstruction {

    private String pointer;

    public LoadInstruction(String result, String type, String pointer) {
        super(result, type);
        this.pointer = pointer;
    }

    public String getPointer() {
        return pointer;
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = load " + this.getType() + ", " + pointer + "\n";
    }
}
