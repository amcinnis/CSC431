package ARM;

import java.util.List;

public class PushARMInstruction extends AbstractARMInstruction {

    private List<String> regList;

    public PushARMInstruction(List<String> regList) {
        this.regList = regList;
    }

    @Override
    public List<String> getTargets() {
        return null;
    }

    @Override
    public List<String> getSources() {
        return null;
    }

    @Override
    public void setTargets(List<String> newTarget) {
        System.out.println("Error! setTargets called on PushARMInstruction");
    }

    @Override
    public void setSources(List<String> newSources) {
        System.out.println("Error! setTargets called on PushARMInstruction");
    }

    @Override
    public String toString() {
        return "\tpush {" + String.join(", ", this.regList) + "}\n";
    }
}
