package ARM;

import java.util.List;

public class ARMString extends AbstractARMInstruction {

    private String str;

    public ARMString(String str) {
        this.str = str;
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
        return str;
    }
}
