package ARM;

import java.util.List;

public class PushARMInstruction extends AbstractARMInstruction {

    private List<String> regList;

    public PushARMInstruction(List<String> regList) {
        this.regList = regList;
    }
}
