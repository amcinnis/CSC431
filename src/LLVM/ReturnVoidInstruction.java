package LLVM;

public class ReturnVoidInstruction extends AbstractInstruction {

    public ReturnVoidInstruction() {

    }

    @Override
    public String toString() {
        return "\tret void\n";
    }
}
