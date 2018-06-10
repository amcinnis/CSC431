package LLVM;

import ARM.*;
import CFG.CFGGenerator;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public abstract class BinaryLLVMInstruction extends ResultingLLVMInstruction {

    private String operand1;
    private String operand2;

    public BinaryLLVMInstruction(String result, String type, String operand1, String operand2) {
        super(result, type);
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public String getOperand1() {
        return operand1;
    }

    public String getOperand2() {
        return operand2;
    }

    public List<ARMInstruction> toARM(String op, HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
        if (isInteger(this.getOperand2()) && Math.abs(Integer.parseInt(this.getOperand2())) >= Math.pow(2, 8)) {
//            instructions.add("\tmovw t1, #lower16:" + getOperand2() +"\n");
            instructions.add(new MoveARMInstruction("w", "t1", "#lower16:" + getOperand2()));
//            instructions.add("\tmovt t1, #upper16:" + getOperand2() + "\n");
            instructions.add(new MoveARMInstruction("t", "t1", "#upper16:" + getOperand2()));
//            instructions.add("\t" + op + " " + this.getResult() + ", " + this.getOperand1() + ", t1\n");
            instructions.addAll(instructionLookup(op, this.getResult(), this.operand1, "t1"));
        }
        else {
            String armOperand1 = armParamLookup(registerMap, this.getOperand1());
            String armOperand2 = armParamLookup(registerMap, this.getOperand2());
//            instructions.add("\t" + op + " " + this.getResult() + ", " + armOperand1 + ", " + armOperand2 + "\n");
            if (!(armOperand1.contains("#") || armOperand2.contains("#"))) {
                instructions.addAll(instructionLookup(op, this.getResult(), armOperand1, armOperand2));
            }
            else {
                String temp1 = null;
                String temp2 = null;
                if (armOperand1.contains("#")) {
                    temp1 = CFGGenerator.newTempRegLabel();
                    instructions.add(new MoveARMInstruction(temp1, armOperand1));
                }
                if (armOperand2.contains("#")) {
                    temp2 = CFGGenerator.newTempRegLabel();
                    instructions.add(new MoveARMInstruction(temp2, armOperand2));
                }

                String finalOp1 = (temp1 == null) ? armOperand1 : temp1;
                String finalOp2 = (temp2 == null) ? armOperand2 : temp2;
                instructions.addAll(instructionLookup(op, this.getResult(), finalOp1, finalOp2));
            }
        }

        return instructions;
    }

    private List<ARMInstruction> instructionLookup(String op, String target, String operand1, String operand2) {
        List<ARMInstruction> instructions = new ArrayList<>();
        switch (op) {
            case "add":
                instructions.add(new AddARMInstruction(target, operand1, operand2));
                break;
            case "sub":
                instructions.add(new SubtractARMInstruction(target, operand1, operand2));
                break;
            case "mul":
                instructions.add(new MultiplyARMInstruction(target, operand1, operand2));
                break;
            case "sdiv":
                CallLLVMInstruction divideCall = new CallLLVMInstruction(target, "i32",
                        "__aeabi_idiv",
                        new ArrayList<>(Arrays.asList("i32 " + operand1, "i32 " + operand2)));
                instructions.addAll(divideCall.toARM(null));
                break;
            case "and":
                instructions.add(new ANDARMInstruction(target, operand1, operand2));
                break;
            case "orr":
                instructions.add(new ORARMInstruction(target, operand1, operand2));
                break;
            case "eor":
                instructions.add(new ExclusiveORARMInstruction(target, operand1, operand2));
                break;
            default:
                System.out.println("Unimplemented op case ine instructionLookup in BinaryLLVMInstruction!");
                return null;
        }
        return instructions;
    }
}
