package ARM;

import java.util.ArrayList;
import java.util.List;

public class BranchARMInstruction extends AbstractARMInstruction {

    private String code;
    private String label;

    public BranchARMInstruction(String label) {
        this.label = label;
        this.code = null;
    }

    public BranchARMInstruction(String code, String label) {
        this.label = label;
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    @Override
    public List<String> getTargets() {
        List<String> targets = new ArrayList<>();
        if (this.code.equals("l")) {
            targets.add("r0");
            targets.add("r1");
            targets.add("r2");
            targets.add("r3");
        }
        return targets;
    }

    @Override
    public List<String> getSources() {
        List<String> sources = new ArrayList<>();
        if (this.code.equals("l")) {
            sources.add("r0");
            sources.add("r1");
            sources.add("r2");
            sources.add("r3");
        }
        return sources;
    }

    @Override
    public void setTargets(List<String> newTarget) {
        System.out.println("Error! setTargets called on BranchARMInstruction");
    }

    @Override
    public void setSources(List<String> newSources) {
        System.out.println("Error! setSources called on BranchARMInstruction");
    }

    @Override
    public String toString() {
        if (this.code == null) {
            return "\tb " + this.label + "\n";
        }
        else {
            return "\tb" + this.code + " " + this.label + "\n";
        }
    }
}
