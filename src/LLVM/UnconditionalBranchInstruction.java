package LLVM;

public class UnconditionalBranchInstruction extends AbstractInstruction {

    private String destination;

    public UnconditionalBranchInstruction(String destination) {
        this.destination = destination;
    }

    @Override
    public String toString() {
        return "br label %" + destination + "\n";
    }
}
