package ARM;

import java.util.ArrayList;
import java.util.List;

public class LoadARMInstruction extends AbstractARMInstruction {

    private String operand1;
    private String operand2;

    public LoadARMInstruction(String operand1, String operand2) {
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
        return "\tldr " + this.operand1 + ", " + this.operand2 + "\n";
    }
}
