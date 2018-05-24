package LLVM;

public abstract class ResultingLLVMInstruction extends AbstractLLVMInstruction {

    private String result;
    private String type;

    public ResultingLLVMInstruction(String result, String type) {
        this.result = result;
        this.type = type;
    }

    public String getResult() {
        return result;
    }

    public String getType() {
        return type;
    }
}
