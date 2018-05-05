package LLVM;

import java.util.List;

public class CallInstruction extends ResultingInstruction {

    private String functionPointer;
    private List<String> functionArgs;

    public CallInstruction(String result, String type, String functionPointer, List<String> functionArgs) {
        super(result, type);
        this.functionPointer = functionPointer;
        this.functionArgs = functionArgs;
    }

    public String getFunctionPointer() {
        return functionPointer;
    }

    public List<String> getFunctionArgs() {
        return functionArgs;
    }

    @Override
    public String toString() {
        String args = String.join(", ", functionArgs);
        String result = this.getResult();
        if (result == null) {
            return "\tcall " + this.getType() + " " + functionPointer + " (" + args + ")\n";
        }
        else {
            return "\t" + this.getResult() + " = call " + this.getType() + " " + functionPointer + "(" + args + ")\n";
        }
    }
}
