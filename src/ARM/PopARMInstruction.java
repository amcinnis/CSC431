package ARM;

import java.util.List;

public class PopARMInstruction extends AbstractARMInstruction {

    private List<String> regList;

    public PopARMInstruction(List<String> regList) {
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
        return "\tpop {" + String.join(", ", this.regList) + "}\n";
    }
}
