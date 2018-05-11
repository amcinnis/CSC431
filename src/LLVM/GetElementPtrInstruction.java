package LLVM;

public class GetElementPtrInstruction extends ResultingInstruction {

    private String pointerValue;
    private String index;

    public GetElementPtrInstruction(String result, String type, String pointerValue, String index) {
        super(result, type);
        this.pointerValue = pointerValue;
        this.index = index;
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = getelementptr " + this.getType() + " " + pointerValue +
                ", i1 0, i32 " + index + "\n";
    }
}
