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
            if (instruction instanceof PushARMInstruction) {
                continue;
            }
            else if (instruction instanceof PopARMInstruction) {
                continue;
            }
            else if (instruction instanceof ARMString) {
                continue;
            }
            else if (instruction instanceof BranchARMInstruction) {
                BranchARMInstruction branch = (BranchARMInstruction)instruction;
                if (branch.getCode() != null && branch.getCode().equals("l")) {
                    //TODO: handle branch and link
                    List<String> sources = branch.getSources();
                    List<String> targets = branch.getTargets();
                    checkSources(ignore, sources);
                    checkTargets(ignore, targets);
                }
            }
            else if (instruction instanceof BinaryARMInstruction) {
                BinaryARMInstruction binary = (BinaryARMInstruction)instruction;
                List<String> sources = binary.getSources();
//                String source1 = binary.getOperand1();
//                String source2 = binary.getOperand2();
                List<String> targets = binary.getTargets();
                checkSources(ignore, sources);
//                checkSources(ignore, source1);
//                checkSources(ignore, source2);
                checkTargets(ignore, targets);
            }
            else if (instruction instanceof CompareARMInstruction) {
                CompareARMInstruction compare = (CompareARMInstruction)instruction;
                List<String> sources = compare.getSources();
                checkSources(ignore, sources);
            }
            else if (instruction instanceof LoadARMInstruction) {
                LoadARMInstruction load = (LoadARMInstruction)instruction;
                List<String> sources = load.getSources();
                List<String> targets = load.getTargets();
                checkSources(ignore, sources);
                checkTargets(ignore, targets);
            }
            else if (instruction instanceof StoreARMInstruction) {
                StoreARMInstruction store = (StoreARMInstruction)instruction;
                List<String> sources = store.getSources();
                checkSources(ignore, sources);
            }
            else if (instruction instanceof MoveARMInstruction) {
                MoveARMInstruction move = (MoveARMInstruction)instruction;
                List<String> sources = move.getSources();
                List<String> targets = move.getTargets();
                checkSources(ignore, sources);
                checkTargets(ignore, targets);
            }
            else {
                System.out.print("Unimplemented instruction in generateGenKill!");
            }
        }
    }

    private void checkSources(HashSet<String> ignore, List<String> sources) {
        for (String source : sources) {
            if (ignore.stream().parallel().noneMatch(source::contains)) {
                if (!(killSet.contains(source))) {
                    genSet.add(source);
                }
            }
        }
    }

    private void checkTargets(HashSet<String> ignore, List<String> targets) {
        for (String target : targets) {
            if (ignore.stream().parallel().noneMatch(target::contains)) {
                killSet.add(target);
            }
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
