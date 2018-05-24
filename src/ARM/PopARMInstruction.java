package ARM;

import java.util.List;

public class PopARMInstruction extends AbstractARMInstruction {

    private List<String> regList;

    public PopARMInstruction(List<String> regList) {
        this.regList = regList;
    }
}
