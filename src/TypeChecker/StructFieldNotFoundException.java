package TypeChecker;

public class StructFieldNotFoundException extends Exception {

    private String structName;

    public StructFieldNotFoundException(String structName) {
        this.structName = structName;
    }

    public void printError(int lineNum, String id) {
        System.out.println("Error! Line " + lineNum + ": Struct '" + this.structName +
                "' does not contain a field named: '" + id + "'!");
    }
}
