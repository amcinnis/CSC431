package LLVM;

public class GetElementPtrInstruction extends ResultingInstruction {

    private String type;
    private String pointerValue;
    private String index;

    public GetElementPtrInstruction(String result, String type, String pointerValue, String index) {
        super(result);
        this.type = type;
        this.pointerValue = pointerValue;
        this.index = index;
    }
}
