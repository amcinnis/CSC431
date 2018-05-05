package LLVM;

public abstract class ResultingInstruction extends AbstractInstruction {

    private String result;
    private String type;

    public ResultingInstruction(String result, String type) {
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
