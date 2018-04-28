package CFG;

public abstract class AbstractCFGNode implements Node {

    private String label;

    public AbstractCFGNode(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }
}
