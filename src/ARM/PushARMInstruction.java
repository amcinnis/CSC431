package ARM;

import java.util.List;

public class PushARMInstruction extends AbstractARMInstruction {

    private List<String> regList;

    public PushARMInstruction(List<String> regList) {
        this.regList = regList;
    }

    @Override
    public String getTarget() {
        return null;
    }

    @Override
    public List<String> getSources() {
        return null;
    }

    @Override
    public String toString() {
        return "\tpush {" + String.join(", ", this.regList) + "}\n";
    }
}
