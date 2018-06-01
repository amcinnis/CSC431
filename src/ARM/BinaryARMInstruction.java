package ARM;

import java.util.ArrayList;
import java.util.List;

public class BinaryARMInstruction extends AbstractARMInstruction {

    private String target;
    private String operand1;
    private String operand2;

    public BinaryARMInstruction(String target, String operand1, String operand2) {
        this.target = target;
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    public String getToString(String op) {
        return "\t" + op + " " + target + ", " + this.operand1 + ", " + this.operand2 + "\n";
    }

    public String getTarget() {
        return target;
    }

    public List<String> getSources() {
        List<String> sources = new ArrayList<>();

        sources.add(operand1);
        sources.add(operand2);

        return sources;
    }

    public String getOperand1() {
        return operand1;
    }

    public String getOperand2() {
        return operand2;
    }
}
