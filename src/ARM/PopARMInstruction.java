package ARM;

import java.util.List;

public class PopARMInstruction extends AbstractARMInstruction {

    private List<String> regList;

    public PopARMInstruction(List<String> regList) {
        this.regList = regList;
    }

    @Override
    public List<String> getTargets() {
        return null;
    }

    @Override
    public void setTargets(List<String> newTarget) {
        System.out.println("Error! setTargets called on PopARMInstruction");
    }

    @Override
    public void setSources(List<String> newSources) {
        System.out.println("Error! setSources called on PopARMInstruction");
    }

    @Override
    public List<String> getSources() {
        return null;
    }

    @Override
    public String toString() {
        return "\tpop {" + String.join(", ", this.regList) + "}\n";
    }
}
