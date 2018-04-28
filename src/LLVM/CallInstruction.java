package LLVM;

import java.util.List;

public class CallInstruction extends ResultingInstruction {

    private String type;
    private String functionPointer;
    private List<String> functionArgs;

    public CallInstruction(String result, String type, String functionPointer, List<String> functionArgs) {
        super(result);
        this.type = type;
        this.functionPointer = functionPointer;
        this.functionArgs = functionArgs;
    }
}
