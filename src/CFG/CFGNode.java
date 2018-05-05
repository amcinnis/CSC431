package CFG;

import LLVM.Instruction;
import java.util.ArrayList;
import java.util.List;

public class CFGNode extends AbstractCFGNode {

    public List <String> miniStatements;
    public List <String> llvmStrings;
    public List <Instruction> llvmInstructions;

    public Node next;

    public CFGNode(String label) {
        super(label);
        miniStatements = new ArrayList<>();
        llvmStrings = new ArrayList<>();
        llvmInstructions = new ArrayList<>();
    }
}
