package LLVM;

public abstract class ResultingInstruction extends AbstractInstruction {

    private String result;

    public ResultingInstruction(String result) {
        this.result = result;
    }

    public String getResult() {
        return result;
    }
}
