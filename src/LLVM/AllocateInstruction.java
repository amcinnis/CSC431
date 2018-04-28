package LLVM;

public class AllocateInstruction extends ResultingInstruction {

    private String type;

    public AllocateInstruction(String result, String type) {
        super(result);
        this.type = type;
    }
}
