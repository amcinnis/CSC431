package ARM;

import java.util.ArrayList;
import java.util.List;

public class MoveARMInstruction extends AbstractARMInstruction {

    private String code;
    private String operand1;
    private String operand2;

    public MoveARMInstruction(String operand1, String operand2) {
        this.code = null;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public MoveARMInstruction(String code, String operand1, String operand2) {
        this.code = code;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    @Override
    public String getTarget() {
        return operand1;
    }

    @Override
    public List<String> getSources() {
        List<String> sources = new ArrayList<>();
        sources.add(operand2);
        return sources;
    }

    public String getOperand1() {
        return operand1;
    }

    public String getOperand2() {
        return operand2;
    }

    @Override
    public String toString() {
        if (this.code == null) {
            return "\tmov " + this.operand1 + ", " + this.operand2 + "\n";
        }
        else {
            return "\tmov"+ this.code + " " + this.operand1 + ", " + this.operand2 + "\n";
        }
    }
}
