package ARM;

import java.util.ArrayList;
import java.util.List;

public class CompareARMInstruction extends AbstractARMInstruction {

    private String operand1;
    private String operand2;

    public CompareARMInstruction(String operand1, String operand2) {
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    @Override
    public List<String> getTargets() {
        return null;
    }

    @Override
    public List<String> getSources() {
        List<String> sources = new ArrayList<>();

        sources.add(operand1);
        sources.add(operand2);

        return sources;
    }

    @Override
    public void setTargets(List<String> newTarget) {

    }

    @Override
    public void setSources(List<String> newSources) {
        if (newSources.size() >= 1) {
            this.operand1 = newSources.get(0);
        }
        if (newSources.size() == 2) {
            this.operand2 = newSources.get(1);
        }
    }

    public String getOperand1() {
        return operand1;
    }

    public String getOperand2() {
        return operand2;
    }

    @Override
    public String toString() {
        return "\tcmp " + this.operand1 + ", " + this.operand2 + "\n";
    }
}
