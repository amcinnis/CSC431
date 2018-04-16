package TypeChecker;

import ast.*;
import sun.jvm.hotspot.opto.Block;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

public class Checker {

    private Program program;

    private HashMap globalsMap = new HashMap();
    private HashMap structsMap = new HashMap();
    private HashMap functionsMap = new HashMap();

    public Checker (Program program) {
        this.program = program;
    }

    public void checkProgram() {

        checkStructs();
        checkDeclarations();
        checkFunctions();
    }

    //Add structs to map
    private void checkStructs() {
        List<TypeDeclaration> types = program.getTypes();
        List<Declaration> fields;
        HashSet<String> fieldNameSet = new HashSet<String>();
        for (TypeDeclaration struct : types) {
            String name = struct.getName();
            if (structsMap.containsKey(name)) {
                System.out.println("Error: Struct \"" + name + "\" previously defined!");
            }
            else {
                structsMap.put(name, struct);
            }

            //Check for duplicate fields in struct
            fields = struct.getFields();
            for (Declaration field : fields) {
                String fieldName = field.getName();
                if (!(fieldNameSet.add(fieldName))) {
                    System.out.println("Error: Field \"" + fieldName + "\" previously defined in struct \"" + name + "\"!");
                }

                //Check if struct name has been previously defined and in scope
                Type fieldType = field.getType();
                if (fieldType instanceof StructType) {
                    StructType structType = (StructType) fieldType;
                    String structTypeName = structType.getName();
                    if (!(structsMap.containsKey(structTypeName))) {
                        System.out.println("Error: struct \"" + structTypeName + "\" not previously defined!");
                    }
                }
            }
            fieldNameSet.clear();
        }
    }

    //Add global declarations to map
    private void checkDeclarations() {
        List<Declaration> decls = program.getDecls();

        for (Declaration decl : decls) {
            String id = decl.getName();
            if (globalsMap.containsKey(id)) {
                System.out.println("Error: Global variable \'" + id + "\" previously defined!");
            } else {
                globalsMap.put(id, decl);
            }
        }
    }

    private void checkFunctions() {
        //Add function declarations to map
        List <Function> funcs = program.getFuncs();

        for (Function function : funcs) {
            String functionName = function.getName();

            //Check for duplicate functions
            if (functionsMap.containsKey(functionName)) {
                System.out.println("Error: Function \"" + functionName + "\" previously defined!");
            }
            else {
                functionsMap.put(functionName, function);
            }

            //Check for duplicate parameters
            HashSet<String> parameterNameSet = new HashSet<String>();
            for (Declaration parameter : function.getParams()) {
                String paramName = parameter.getName();
                if (!(parameterNameSet.add(paramName))) {
                    System.out.println("Error: Parameter \"" + paramName + "\" in function \"" + functionName
                            + "\" was previously defined!");
                }
            }

            //Check for duplicate variables
            HashSet<String> varNameSet = new HashSet<String>();
            for (Declaration variable : function.getLocals()) {
                String varName = variable.getName();
                if (!(varNameSet.add(varName))) {
                    System.out.println("Error: Variable \"" + varName + "\" in function \"" + functionName
                            + "\" was previously defined!");
                }

                //Check for variables with same name as params
                if (parameterNameSet.contains(varName)) {
                    System.out.println("Error: Variable \"" + varName + "\" may not redeclare parameter of same name!");
                }
            }

            //Check for valid main function
            if (functionName.equals("main")) {
                if (function.getParams().size() > 0) {
                    System.out.println("Error: \"main\" function requires zero arguments");
                }
                if (!(function.getRetType() instanceof IntType)) {
                    System.out.println("Error: \"main\" function requires return type of type 'int'");
                }
            }

            //Check body for function validity
            Statement body = function.getBody();
            if (body instanceof BlockStatement) {
                BlockStatement newBlock = (BlockStatement) body;
                checkBlockStatement(newBlock, functionName);
                Type retType = function.getRetType();
                if (!(retType instanceof VoidType)) {
                    if (newBlock.getStatements().size() > 0) {
                        validateReturn(newBlock, functionName);
                    }
                    else {
                        System.out.println("Error! Line " + newBlock.getLineNum() + ": Function '" + functionName +
                                "' expects return type of type " + typeToString(retType) +
                                " but is missing a return statement!");
                    }
                }
            }
        }

        //Check for main function
        if (!functionsMap.containsKey("main")) {
            System.out.println("Error!: Program is missing main method!");
        }
    }

    private void validateReturn(BlockStatement block, String functionName) {
        //TODO Check for standard vs. control flow case
        //Check statements in body.
        // If return type is not null,
        // If contains return statement, return valid.
        // Else, if contains conditional statement, (recursively?) check for returns in both then and else.

        List <Statement> statements = block.getStatements();
        //Check to see if first statement is a block statement
        Statement first = statements.get(0);
        if (first instanceof BlockStatement) {
            BlockStatement nestedBlock = (BlockStatement) first;
            validateReturn(nestedBlock, functionName);
        }
        else {
            Boolean containsReturn = false;

            for (Statement statement : statements) {
                if (statement instanceof ReturnStatement) {
                    containsReturn = true;
                }
            }

            if (!containsReturn) {
                //Check for Conditional
                for (Statement statement : statements) {
                    if (statement instanceof ConditionalStatement) {
                        ConditionalStatement conditional = (ConditionalStatement) statement;
                        containsReturn = validateConditionalReturn(conditional);
                        if (!containsReturn) {
                            System.out.println("Error!: Function '" + functionName + "' does not have valid return structure!");
                        }
                    }
                }
            }
        }
    }

    private boolean validateConditionalReturn(ConditionalStatement statement) {
        boolean thenReturn = false, elseReturn = false;
        Statement thenBlock = statement.getThenBlock();
        Statement elseBlock = statement.getElseBlock();
        int thenLineNum = -1, elseLineNum = -1;

        if (thenBlock instanceof BlockStatement) {
            BlockStatement tB = (BlockStatement) thenBlock;
            thenReturn = validateConditionalBlock(tB);
            thenLineNum = tB.getLineNum();
        }

        if (elseBlock instanceof BlockStatement) {
            BlockStatement eB = (BlockStatement) elseBlock;
            elseLineNum = eB.getLineNum();
            //Empty else case
            if (elseLineNum < 0) {
                return thenReturn;
            }
            elseReturn = validateConditionalBlock(eB);
        }

        if (thenReturn && !elseReturn) {
            System.out.println("Error! Line " + elseLineNum + ": Else block does not contain return statement when " +
                    "preceding if block does!");
        }
        else if (!thenReturn && elseReturn) {
            System.out.println("Error! Line " + thenLineNum + ": If block does not contain return statement when " +
                    "following else block does!");
        }

        return (thenReturn && elseReturn);
    }

    private boolean validateConditionalBlock(BlockStatement block) {
        List <Statement> statements = block.getStatements();
        boolean containsReturn = false;

        for (Statement statement : statements) {
            if (statement instanceof ReturnStatement) {
                containsReturn = true;
            }
        }

        if (!containsReturn) {
            for (Statement statement : statements) {
                if (statement instanceof ConditionalStatement) {
                    ConditionalStatement conditional = (ConditionalStatement) statement;
                    boolean tmp = validateConditionalReturn(conditional);
                    if (!containsReturn && tmp) {
                        containsReturn = true;
                    }
                }
            }
        }

        return containsReturn;
     }

    private void checkBlockStatement(BlockStatement block, String functionName) {
        List <Statement> statements = block.getStatements();

        for (Statement statement : statements) {
            //Invocation
            if (statement instanceof InvocationStatement) {
                InvocationStatement invocation = (InvocationStatement) statement;
                checkInvocationStatement(invocation, functionName);
            }
            //Conditional
            else if (statement instanceof ConditionalStatement) {
                ConditionalStatement conditional = (ConditionalStatement) statement;
                checkConditionalStatement(conditional, functionName);
            }
            //While
            else if (statement instanceof WhileStatement) {
                WhileStatement whileStatement = (WhileStatement) statement;
                checkWhileStatement(whileStatement, functionName);
            }
            //Block
            else if (statement instanceof BlockStatement) {
                BlockStatement newBlock = (BlockStatement) statement;
                checkBlockStatement(newBlock, functionName);
            }
            //Assignment
            else if (statement instanceof AssignmentStatement) {
                AssignmentStatement newAssignment = (AssignmentStatement) statement;
                checkAssignmentStatement(newAssignment, functionName);
            }
            //Print
            else if (statement instanceof PrintStatement) {
                PrintStatement printStatement = (PrintStatement) statement;
                checkPrintStatement(printStatement, functionName);
            }
            //PrintLn
            else if (statement instanceof PrintLnStatement) {
                PrintLnStatement printLnStatement = (PrintLnStatement) statement;
                checkPrintLnStatement(printLnStatement, functionName);
            }
            //Return
            else if (statement instanceof ReturnStatement) {
                ReturnStatement returnStatement = (ReturnStatement) statement;
                checkReturnStatement(returnStatement, functionName);
            }
            //ReturnEmpty
            else if (statement instanceof  ReturnEmptyStatement) {
                ReturnEmptyStatement returnEmptyStatement = (ReturnEmptyStatement) statement;
                checkReturnEmptyStatement(returnEmptyStatement, functionName);
            }
        }
    }

    private void checkReturnEmptyStatement(ReturnEmptyStatement returnEmptyStatement, String functionName) {
        int lineNum = returnEmptyStatement.getLineNum();

        Function function = getFunction(functionName, lineNum);
        if (function != null) {
            Type returnType = function.getRetType();

            if (!(returnType instanceof VoidType)) {
                System.out.println("Error! Line " + lineNum + ": Funtion '" + functionName +
                        "' requires return of type " + typeToString(returnType) + ".");
            }
        }
    }

    private void checkReturnStatement(ReturnStatement returnStatement, String functionName) {
        Expression expression = returnStatement.getExpression();
        Type returnType = getExpressionType(expression, functionName);
        Function function = getFunction(functionName, returnStatement.getLineNum());

        if (function != null) {
            Type declaredReturnType = function.getRetType();

            if (returnType != null) {
                if (!(returnType.getClass().equals(declaredReturnType.getClass()))) {
                    int lineNum = ((AbstractExpression) expression).getLineNum();
                    System.out.println("Error! Line " + lineNum + ": Return type of type '" + typeToString(returnType) +
                            "' does not match declared return type of type '" + typeToString(declaredReturnType) + "'.");
                }
            }
            else {
                System.out.println("Null return type");
            }
        }
    }

    private void checkAssignmentStatement(AssignmentStatement assignment, String functionName) {
        //Get type of LValue, get type of source, make sure they match
        Lvalue lvalue = assignment.getTarget();
        Expression right = assignment.getSource();

        Type rightType = getExpressionType(right, functionName);
        Type leftType = null;
        String leftId = null;
        int lineNum = -1;

        if (lvalue instanceof LvalueId) {
            LvalueId left = (LvalueId) lvalue;
            leftId = left.getId();
            lineNum = left.getLineNum();
            leftType = getIdentifierType(leftId, functionName);
        }
        else if (lvalue instanceof LvalueDot) {
            LvalueDot top = (LvalueDot) lvalue;
            leftId = top.getId();

            Type leftStructType = getLValueDotType(top.getLeft(), functionName);
            try {
                leftType = getStructFieldType(leftStructType, leftId);
            }
            catch (StructFieldNotFoundException e) {
                e.printError(top.getLineNum(), leftId);
            }
        }

        if (rightType != null) {
            if (leftType != null) {
                if (!(leftType.getClass().equals(rightType.getClass()))) {
                    System.out.println("Line " + lineNum + ": Incompatible types in assignment! " +
                            leftId + ":" + typeToString(leftType) + " R:" + typeToString(rightType));
                }
            }
            else {
                System.out.println("LHS of AssignmentStatement is null!");
            }
        }
    }

    private String typeToString(Type type) {
        if (type instanceof IntType) {
            return "Integer";
        }
        else if (type instanceof BoolType) {
            return "Boolean";
        }
        else if (type instanceof StructType) {
            return "Struct";
        }
        else if (type instanceof VoidType) {
            return "Void";
        }
        else {
            return "Undefined";
        }
    }

    private Type getLValueDotType(Expression left, String functionName) {
        if (left instanceof IdentifierExpression) {
            IdentifierExpression idExp = (IdentifierExpression) left;
            String farLeftName = idExp.getId();
            Type farLeftType = getIdentifierType(farLeftName, functionName);

            //Verify far left identifier is of type struct
            if (farLeftType instanceof StructType) {
                return farLeftType;
            }
            else {
                System.out.println(farLeftName + "is not of type 'struct'!");
            }
        }
        else if (left instanceof InvocationExpression) {
            InvocationExpression invocationExpression = (InvocationExpression) left;
            String invExpName = invocationExpression.getName();

            if (functionsMap.containsKey(invExpName)) {
                Function function = getFunction(invExpName, invocationExpression.getLineNum());
                if (function != null) {
                    return function.getRetType();
                }
            }
            else {
                int lineNum = invocationExpression.getLineNum();
                System.out.println("Error! Line " + lineNum + ": Function '" +
                        invExpName + "' not previously defined!");
            }
        }
        else if (left instanceof DotExpression) {
            DotExpression leftExp = (DotExpression) left;
            Expression nextExp = leftExp.getLeft();
            String nextId = leftExp.getId();

            Type leftType = getLValueDotType(nextExp, functionName);
            try {
                return getStructFieldType(leftType, nextId);
            }
            catch (StructFieldNotFoundException e) {
                e.printError(leftExp.getLineNum(), nextId);
            }
        }

        return null;
    }

    private Type getStructFieldType(Type leftType, String id) throws StructFieldNotFoundException {
        if (leftType instanceof StructType) {
            StructType structType = (StructType) leftType;

            //Get struct name
            String structName = structType.getName();
            //Lookup struct in structsMap
            if (structsMap.containsKey(structName)) {
                TypeDeclaration struct = (TypeDeclaration) structsMap.get(structName);
                //Verify struct has a field with same name as 'id'
                List<Declaration> fields = struct.getFields();
                for (Declaration field : fields) {
                    if (field.getName().equals(id)) {
                        //Return type of field in struct
                        return field.getType();
                    }
                }
                throw new StructFieldNotFoundException(structName);
            } else {
                System.out.println("Struct " + structName + " not previously defined!");
            }
        }
        else {
            if (leftType instanceof IntType) {
                throw new StructFieldNotFoundException("IntType");
            }
            else if (leftType instanceof BoolType) {
                throw new StructFieldNotFoundException("BoolType");
            }
            else if (leftType instanceof VoidType) {
                throw new StructFieldNotFoundException("VoidType");
            }

        }

        return null;
    }

    private void checkInvocationStatement(InvocationStatement invocation, String functionName) {
        Expression expression = invocation.getExpression();
        if (expression instanceof InvocationExpression) {
            InvocationExpression invocationExpression = (InvocationExpression) expression;
            String invExpName = invocationExpression.getName();
            int lineNum = invocation.getLineNum();
            Function function = getFunction(invExpName, lineNum);

            if (function != null) {
                List <Expression> arguments = invocationExpression.getArguments();
                List <Declaration> parameters = function.getParams();

                if (arguments.size() != parameters.size()) {
                    System.out.println("Error! Line " + lineNum + ": Number of arguments do not match number of " +
                            "parameters for function '" + invExpName + "'.");
                }
                else {
                    Type argType, paramType;
                    for (int i = 0; i < arguments.size(); i++) {
                        Expression argument = arguments.get(i);
                        Declaration parameter = parameters.get(i);

                        argType = getExpressionType(argument, functionName);
                        paramType = parameter.getType();

                        if (argType != null) {
                            if (!(argType.getClass().equals(paramType.getClass()))) {
                                System.out.println("Error! Line " + lineNum + ": Argument " + (i+1) + " of function '" + invExpName +
                                        "' expects argument of type " + typeToString(paramType)
                                        + ", found " + typeToString(argType) + ".");
                            }
                        }
                        else {
                            System.out.println("Received null return type for argument from getExpressionType()");
                        }
                    }
                }
            }

        }
    }

    private Function getFunction(String functionName, int lineNum) {
        if (functionsMap.containsKey(functionName)) {
            Function function = (Function) functionsMap.get(functionName);
            return function;
        }
        else {
            System.out.println("Error! Line " + lineNum + ": Function '" +
                    functionName + "' not previously defined!");
            return null;
        }
    }

    private void checkConditionalStatement(ConditionalStatement conditional, String functionName) {
        Expression guardExp = conditional.getGuard();
        checkGuardExpression(guardExp, functionName);

        Statement thenStatement = conditional.getThenBlock();
        Statement elseStatement = conditional.getElseBlock();
        if (thenStatement instanceof BlockStatement) {
            BlockStatement thenBlock = (BlockStatement) thenStatement;
            checkBlockStatement(thenBlock, functionName);
        }
        if (elseStatement instanceof BlockStatement) {
            BlockStatement elseBlock = (BlockStatement) elseStatement;
            checkBlockStatement(elseBlock, functionName);
        }
    }

    private void checkWhileStatement(WhileStatement whileStatement, String functionName) {
        Expression guardExp = whileStatement.getGuard();
        checkGuardExpression(guardExp, functionName);

        Statement body = whileStatement.getBody();
        if (body instanceof BlockStatement) {
            BlockStatement blockStatement = (BlockStatement) body;
            checkBlockStatement(blockStatement, functionName);
        }
    }

    private void checkGuardExpression(Expression guardExp, String functionName) {
        if (guardExp instanceof BinaryExpression) {
            BinaryExpression guard = (BinaryExpression) guardExp;

            BinaryExpression.Operator operator = guard.getOperator();
            String opName = operator.name();

            Expression left = guard.getLeft();
            Expression right = guard.getRight();

            Type leftType = getExpressionType(left, functionName);
            Type rightType = getExpressionType(right, functionName);
            int lineNum = ((AbstractExpression) left).getLineNum();

            //TODO Account for null RHS
            if (opName.equals("AND") || opName.equals("OR")) {
                //Check that leftType and rightType are both BoolType
                if (!(leftType instanceof BoolType && rightType instanceof BoolType)) {
                    System.out.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                            "Logical operators require both types to be of type boolean.");
                }
            }
            else if (opName.equals("EQ") || opName.equals("NE")) {
                //Check that leftType and rightType are same type
                if (!(leftType instanceof IntType || leftType instanceof StructType)) {
                    if (!(leftType.equals(rightType))) {
                        System.out.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                                "Equality operators require types to be of same type integer or struct.");
                    }
                }
            }
            else {
                //Check that leftType and rightType are both IntType
                if (!(leftType instanceof IntType && rightType instanceof IntType)) {
                    System.out.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                            "Arithmetic and Relational operators require both types to be of type int.");
                }
            }
        }
        else {
            System.out.println("Non Binary expression in guard of Conditional");
        }
    }

    private void checkPrintStatement(PrintStatement printStatement, String functionName) {
        Expression expression = printStatement.getExpression();
        Type type = getExpressionType(expression, functionName);

        if (!(type instanceof IntType)) {
            int lineNum = ((AbstractExpression) expression).getLineNum();
            System.out.println("Error! Line " + lineNum + ": Print statement requires integer argument.");
        }
    }

    private void checkPrintLnStatement(PrintLnStatement printLnStatement, String functionName) {
        Expression expression = printLnStatement.getExpression();
        Type type = getExpressionType(expression, functionName);

        if (!(type instanceof IntType)) {
            int lineNum = ((AbstractExpression) expression).getLineNum();
            System.out.println("Error! Line " + lineNum + ": PrintLn statement requires integer argument.");
        }
    }

    private Type getExpressionType(Expression expression, String functionName) {
        if (expression instanceof IntegerExpression) {
            return new IntType();
        }
        else if (expression instanceof TrueExpression || expression instanceof FalseExpression) {
            return new BoolType();
        }
        else if (expression instanceof InvocationExpression) {
            InvocationExpression invocationExpression = (InvocationExpression) expression;
            String name = invocationExpression.getName();

            //Find function return type in functions HashMap
            Function function = getFunction(functionName, invocationExpression.getLineNum());
            if (function != null) {
                return function.getRetType();
            }
        }
        else if (expression instanceof IdentifierExpression) {
            IdentifierExpression identifierExpression = (IdentifierExpression) expression;
            String name = identifierExpression.getId();

            return getIdentifierType(name, functionName);
        }
        else if (expression instanceof UnaryExpression) {
            UnaryExpression unaryExpression = (UnaryExpression) expression;
            return getExpressionType(unaryExpression.getOperand(), functionName);
        }
        else if (expression instanceof DotExpression) {
            DotExpression dotExpression = (DotExpression) expression;
            String id = dotExpression.getId();
            Expression left = dotExpression.getLeft();

            Type lType = getLValueDotType(left, functionName);
            try {
                return getStructFieldType(lType, id);
            }
            catch (StructFieldNotFoundException e) {
                e.printError(dotExpression.getLineNum(), id);
            }
        }
        else if (expression instanceof NullExpression) {
            return null;
        }
        else if (expression instanceof BinaryExpression) {
            BinaryExpression binaryExpression = (BinaryExpression) expression;
            BinaryExpression.Operator operator = binaryExpression.getOperator();
            String opName = operator.name();

            Expression left = binaryExpression.getLeft();
            Expression right = binaryExpression.getRight();
            int lineNum = ((AbstractExpression) left).getLineNum();

            Type leftType = getExpressionType(left, functionName);
            Type rightType = getExpressionType(right, functionName);

            //TODO Account for null RHS
            if (opName.equals("AND") || opName.equals("OR")) {
                //Check that leftType and rightType are both BoolType
                if (!(leftType instanceof BoolType && rightType instanceof BoolType)) {
                    System.out.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                            "Logical operators require both types to be of type boolean.");
                }
                else {
                    return new BoolType();
                }
            }
            else if (opName.equals("EQ") || opName.equals("NE")) {
                //Check that leftType and rightType are same type
                if (!(leftType instanceof IntType || leftType instanceof StructType)) {
                    if (!(leftType.equals(rightType))) {
                        System.out.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                                "Equality operators require types to be of same type integer or struct.");
                    }
                }
                else {
                    return new BoolType();
                }
            }
            else {
                //Check that leftType and rightType are both IntType
                if (!(leftType instanceof IntType && rightType instanceof IntType)) {
                    System.out.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                            "Arithmetic and Relational operators require both types to be of type int.");
                }
                else {
                    if (opName.equals("GT") || opName.equals("GE") || opName.equals("LT") || opName.equals("LE")) {
                        return new BoolType();
                    }
                    else {
                        return new IntType();
                    }
                }
            }
        }
        else {
            System.out.println("Unaccounted for Expression in getExpressionType!");
        }

        return null;
    }

    private Type getIdentifierType(String name, String functionName) {
        Function function = (Function) functionsMap.get(functionName);

        //Check local scope
        List <Declaration> locals = function.getLocals();
        for (Declaration local : locals) {
            if (name.equals(local.getName())) {
                return local.getType();
            }
        }

        //Check function parameters
        List <Declaration> params = function.getParams();
        for (Declaration param : params) {
            if (name.equals(param.getName())) {
                return param.getType();
            }
        }

        //Check global scope
        if (globalsMap.containsKey(name)) {
            Declaration identifier = (Declaration) globalsMap.get(name);
            return identifier.getType();
        }

        System.out.println("Error! Cannot find identifier \"" + name + "\"!");

        return null;
    }
}