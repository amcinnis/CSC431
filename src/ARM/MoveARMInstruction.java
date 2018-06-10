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
    public List<String> getTargets() {
        List <String> targets = new ArrayList<>();
        targets.add(operand1);
        return targets;
    }

    @Override
    public List<String> getSources() {
        List<String> sources = new ArrayList<>();
        sources.add(operand2);
        return sources;
    }

    @Override
    public void setTargets(List<String> newTarget) {
        this.operand1 = newTarget.get(0);
    }

    @Override
    public void setSources(List<String> newSources) {
        this.operand2 = newSources.get(0);
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
