package ARM;

import java.util.List;

public interface ARMInstruction {

    List<String> getTargets();
    void setTargets(List<String> newTarget);
    List<String> getSources();
    void setSources(List<String> newSources);
}
