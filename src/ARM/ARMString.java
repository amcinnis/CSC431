package ARM;

import java.util.List;

public class ARMString extends AbstractARMInstruction {

    private String str;

    public ARMString(String str) {
        this.str = str;
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
        System.out.println("Error! setTargets called on ARMString!");
    }

    @Override
    public void setSources(List<String> newSources) {
        System.out.println("Error! setSources called on ARMString!");
    }

    @Override
    public String toString() {
        return str;
    }
}
