package ARM;

import java.util.List;

public interface ARMInstruction {

    String getTarget();
    List<String> getSources();
}
