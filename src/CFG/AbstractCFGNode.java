package CFG;

import ARM.*;
import LLVM.LLVMInstruction;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

public abstract class AbstractCFGNode implements Node {

    private String label;
    public Node pred0;
    public Node pred1;
    public List<LLVMInstruction> LLVMInstructions;
    public List<ARMInstruction> ARMInstructions;
    public List<String> llvmStrings;
//    public List<String> armStrings;
    public HashSet<String> genSet;
    public HashSet<String> killSet;
    public HashSet<String> liveOut;
    public boolean visited;

    public AbstractCFGNode(String label) {
        this.label = label;
        this.pred1 = null;
        this.pred0 = null;
        this.LLVMInstructions = new ArrayList<>();
        this.ARMInstructions = new ArrayList<>();
        this.llvmStrings = new ArrayList<>();
//        this.armStrings = new ArrayList<>();
        this.genSet = new HashSet<>();
        this.killSet = new HashSet<>();
        this.liveOut = new HashSet<>();
    }

    public void generateGenKill() {
        HashSet<String> ignore = new HashSet<>();
        ignore.add("fp");
        ignore.add("sp");
        ignore.add("#");
        ignore.add("lr");
        ignore.add("pc");

        for (ARMInstruction instruction : ARMInstructions) {
            if (instruction instanceof BranchARMInstruction) {
                continue;
            }
            else if (instruction instanceof PushARMInstruction) {
                continue;
            }
            else if (instruction instanceof PopARMInstruction) {
                continue;
            }
            else if (instruction instanceof ARMString) {
                continue;
            }
            else if (instruction instanceof BinaryARMInstruction) {
                BinaryARMInstruction binary = (BinaryARMInstruction)instruction;
                String source1 = binary.getOperand1();
                String source2 = binary.getOperand2();
                String target = binary.getTarget();
                checkSource(ignore, source1);
                checkSource(ignore, source2);
                checkTarget(ignore, target);
            }
            else if (instruction instanceof CompareARMInstruction) {
                CompareARMInstruction compare = (CompareARMInstruction)instruction;
                String source1 = compare.getOperand1();
                String source2 = compare.getOperand2();
                checkSource(ignore, source1);
                checkSource(ignore, source2);
            }
            else if (instruction instanceof LoadARMInstruction) {
                LoadARMInstruction load = (LoadARMInstruction)instruction;
                String source = load.getOperand2();
                String target = load.getOperand1();
                checkSource(ignore, source);
                checkTarget(ignore, target);
            }
            else if (instruction instanceof StoreARMInstruction) {
                StoreARMInstruction store = (StoreARMInstruction)instruction;
                String source1 = store.getOperand1();
                String source2 = store.getOperand2();
                checkSource(ignore, source1);
                checkSource(ignore, source2);
            }
            else if (instruction instanceof MoveARMInstruction) {
                MoveARMInstruction move = (MoveARMInstruction)instruction;
                String source = move.getOperand2();
                String target = move.getOperand1();
                checkSource(ignore, source);
                checkTarget(ignore, target);
            }
            else {
                System.out.print("Unimplemented instruction in generateGenKill!");
            }
        }
    }

    private void checkSource(HashSet<String> ignore, String source) {
        if (ignore.stream().parallel().noneMatch(source::contains)) {
            if (!(killSet.contains(source))) {
                genSet.add(source);
            }
        }
    }

    private void checkTarget(HashSet<String> ignore, String target) {
        if (ignore.stream().parallel().noneMatch(target::contains)) {
            killSet.add(target);
        }
    }

    public String getLabel() {
        return label;
    }

    @Override
    public String toString() {
        return this.label;
    }
}
