package LLVM;

public class LoadInstruction extends ResultingInstruction {

    private String type;
    private String pointer;

    public LoadInstruction(String result, String type, String pointer) {
        super(result);
        this.type = type;
        this.pointer = pointer;
    }
}
