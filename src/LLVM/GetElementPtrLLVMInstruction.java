package LLVM;

import ARM.ARMInstruction;
import ARM.AddARMInstruction;
import ARM.MoveARMInstruction;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class GetElementPtrLLVMInstruction extends ResultingLLVMInstruction {

    private String pointerValue;
    private String index;

    public GetElementPtrLLVMInstruction(String result, String type, String pointerValue, String index) {
        super(result, type);
        this.pointerValue = pointerValue;
        this.index = index;
    }

    public String getIndex() {
        return index;
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = getelementptr " + this.getType() + " " + pointerValue +
                ", i1 0, i32 " + index + "\n";
    }

    @Override
    public List<ARMInstruction> toARM(HashMap<String, String> registerMap) {
        List<ARMInstruction> instructions = new ArrayList<>();
//        instructions.add("\tadd " + this.getResult() + ", " + this.pointerValue + ", #8\n");
        String armOperand1 = armParamLookup(registerMap, this.pointerValue);
        if (isInteger(this.index)) {
            int offset = Integer.parseInt(this.index);
            if (offset > 0) {
//                instructions.add("\tadd " + this.getResult() + ", " + armOperand1 + ", #" +
//                        Integer.toString(4*offset) + "\n");
                instructions.add(new AddARMInstruction(this.getResult(), armOperand1,
                        "#" + Integer.toString(4*offset)));
            }
            else {
//                instructions.add("\tmov " + this.getResult() + ", " + armOperand1 + "\n");
                instructions.add(new MoveARMInstruction(this.getResult(), armOperand1));
            }
        }
        return instructions;
    }
}
