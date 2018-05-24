package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class CallLLVMInstruction extends ResultingLLVMInstruction {

    private String functionPointer;
    private List<String> functionArgs;

    public CallLLVMInstruction(String result, String type, String functionPointer, List<String> functionArgs) {
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
            return "\tcall " + this.getType() + " @" + functionPointer + "(" + args + ")\n";
        }
        else {
            return "\t" + this.getResult() + " = call " + this.getType() + " @" + functionPointer + "(" + args + ")\n";
        }
    }

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
        int paramRegCount = 0;
        for (String arg : this.functionArgs) {
            String regLabel = arg.split(" ")[1];
            if (isInteger(regLabel)) {
                int size = (Integer.parseInt(regLabel) / 2);
                instructions.add("\tmovw r" + paramRegCount++ + ", #" + Integer.toString(size) + "\n");
            }
            else {
                instructions.add("\tmov r" + paramRegCount++ + ", " + regLabel + "\n");
            }
        }

        instructions.add("\tbl " + this.functionPointer + "\n");
        if (this.getResult() != null) {
            instructions.add("\tmov " + this.getResult() + ", r0\n");
        }

        return instructions;
    }
}
