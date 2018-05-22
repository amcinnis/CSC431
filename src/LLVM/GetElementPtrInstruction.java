package LLVM;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

    @Override
    public List<String> toARM(HashMap<String, String> registerMap) {
        List<String> instructions = new ArrayList<>();
//        instructions.add("\tadd " + this.getResult() + ", " + this.pointerValue + ", #8\n");
        String armOperand1 = armParamLookup(registerMap, this.pointerValue);
        if (isInteger(this.index)) {
            int offset = Integer.parseInt(this.index);
            if (offset > 0) {
                instructions.add("\tadd " + this.getResult() + ", " + armOperand1 + ", #" +
                        Integer.toString(4*offset) + "\n");
            }
            else {
                instructions.add("\tmov " + this.getResult() + ", " + armOperand1 + "\n");
            }
        }
        return instructions;
    }
}
