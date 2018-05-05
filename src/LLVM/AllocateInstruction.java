package LLVM;

public class AllocateInstruction extends ResultingInstruction {

    public AllocateInstruction(String result, String type) {
        super(result, type);
    }

    @Override
    public String toString() {
        return "\t" + this.getResult() + " = alloca " + this.getType() + "\n";
    }
}
