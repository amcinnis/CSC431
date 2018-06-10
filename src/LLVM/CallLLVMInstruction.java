package LLVM;

import ARM.*;

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
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
        int paramRegCount = 0;

        if (this.functionPointer.equals("scanf")) {
            instructions.add(new MoveARMInstruction("w", "r1", "#:lower16:.read_scratch"));
            instructions.add(new MoveARMInstruction("t", "r1", "#:upper16:.read_scratch"));
            instructions.add(new MoveARMInstruction("w", "r0", "#:lower16:.READ_FMT"));
            instructions.add(new MoveARMInstruction("t", "r0", "#:upper16:.READ_FMT"));
            instructions.add(new BranchARMInstruction("l", this.functionPointer));
            instructions.add(new MoveARMInstruction("w", "r0", "#:lower16:.read_scratch"));
            instructions.add(new MoveARMInstruction("t", "r0", "#:upper16:.read_scratch"));
            String destinationArg = this.functionArgs.get(1).split(" ")[1];
            String destination = registerMap.get(destinationArg);
            if (destination == null) {
                instructions.add(new LoadARMInstruction(destinationArg, "r0"));
            }
            else {
                instructions.add(new LoadARMInstruction("r0", "r0"));
                instructions.add(new StoreARMInstruction("r0", destination));
            }
            return instructions;
        }

        if (this.functionPointer.equals("printf")) {
            String destinationArg = this.functionArgs.get(1).split(" ")[1];
            instructions.add(new MoveARMInstruction("r1", destinationArg));

            String printArg = this.getFunctionArgs().get(0);
            String format = (printArg.contains("@.println")) ? ".PRINTLN_FMT" : ".PRINT_FMT";
            instructions.add(new MoveARMInstruction("w", "r0", "#:lower16:" + format));
            instructions.add(new MoveARMInstruction("t", "r0", "#:upper16:" + format));
            instructions.add(new BranchARMInstruction("l", this.functionPointer));
            return instructions;
        }

        for (String arg : this.functionArgs) {
            String regLabel = arg.split(" ")[1];
            if (this.functionPointer.equals("malloc") && isInteger(regLabel)) {
                int size = (Integer.parseInt(regLabel) / 2);
                instructions.add(new MoveARMInstruction("w", "r" + paramRegCount++,
                        "#" + Integer.toString(size)));
            }
            else if (isInteger(regLabel)) {
                instructions.add(new MoveARMInstruction("r" + paramRegCount++, "#" + regLabel));
            }
            else {
                instructions.add(new MoveARMInstruction("r" + paramRegCount++, regLabel));
            }
        }

        instructions.add(new BranchARMInstruction("l", this.functionPointer));
        if (this.getResult() != null) {
            instructions.add(new MoveARMInstruction(this.getResult(), "r0"));
        }

        return instructions;
    }
}
