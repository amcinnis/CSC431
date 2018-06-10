package TypeChecker;

import ast.*;
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
                System.err.println("Error: Struct \"" + name + "\" previously defined!");
                System.exit(1);
            }
            else {
                structsMap.put(name, struct);
            }

            //Check for duplicate fields in struct
            fields = struct.getFields();
            for (Declaration field : fields) {
                String fieldName = field.getName();
                if (!(fieldNameSet.add(fieldName))) {
                    System.err.println("Error: Field \"" + fieldName + "\" previously defined in struct \"" + name + "\"!");
                    System.exit(1);
                }

                //Check if struct name has been previously defined and in scope
                Type fieldType = field.getType();
                if (fieldType instanceof StructType) {
                    StructType structType = (StructType) fieldType;
                    String structTypeName = structType.getName();
                    if (!(structsMap.containsKey(structTypeName))) {
                        System.err.println("Error: struct \"" + structTypeName + "\" not previously defined!");
                        System.exit(1);
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
                System.err.println("Error: Global variable \'" + id + "\" previously defined!");
                System.exit(1);
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
                System.err.println("Error: Function \"" + functionName + "\" previously defined!");
                System.exit(1);
            }
            else {
                functionsMap.put(functionName, function);
            }

            //Check for duplicate parameters
            HashSet<String> parameterNameSet = new HashSet<String>();
            for (Declaration parameter : function.getParams()) {
                String paramName = parameter.getName();
                if (!(parameterNameSet.add(paramName))) {
                    System.err.println("Error: Parameter \"" + paramName + "\" in function \"" + functionName
                            + "\" was previously defined!");
                    System.exit(1);
                }
            }

            //Check for duplicate variables
            HashSet<String> varNameSet = new HashSet<String>();
            for (Declaration variable : function.getLocals()) {
                String varName = variable.getName();
                if (!(varNameSet.add(varName))) {
                    System.err.println("Error: Variable \"" + varName + "\" in function \"" + functionName
                            + "\" was previously defined!");
                    System.exit(1);
                }

                //Check for variables with same name as params
                if (parameterNameSet.contains(varName)) {
                    System.err.println("Error: Variable \"" + varName + "\" may not redeclare parameter of same name!");
                    System.exit(1);
                }
            }

            //Check for valid main function
            if (functionName.equals("main")) {
                if (function.getParams().size() > 0) {
                    System.err.println("Error: \"main\" function requires zero arguments");
                    System.exit(1);
                }
                if (!(function.getRetType() instanceof IntType)) {
                    System.err.println("Error: \"main\" function requires return type of type 'int'");
                    System.exit(1);
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
                        System.err.println("Error! Line " + newBlock.getLineNum() + ": Function '" + functionName +
                                "' expects return type of type " + typeToString(retType) +
                                " but is missing a return statement!");
                        System.exit(1);
                    }
                }
            }
        }

        //Check for main function
        if (!functionsMap.containsKey("main")) {
            System.err.println("Error!: Program is missing main method!");
            System.exit(1);
        }
    }

    private void validateReturn(BlockStatement block, String functionName) {
        List <Statement> statements = block.getStatements();
        Boolean containsReturn = false;

        //Check to see if there is a return statement in list of statements
        for (Statement statement : statements) {
            if (statement instanceof ReturnStatement) {
                containsReturn = true;
            }
        }

        if (containsReturn) { return; }

        //Otherwise, Check to see if first statement is a block statement
        Statement first = statements.get(0);
        if (first instanceof BlockStatement) {
            BlockStatement nestedBlock = (BlockStatement) first;
            validateReturn(nestedBlock, functionName);
        }
        else {
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
                            System.err.println("Error!: Function '" + functionName + "' does not have valid return structure!");
                            System.exit(1);
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
            System.err.println("Error! Line " + elseLineNum + ": Else block does not contain return statement when " +
                    "preceding if block does!");
            System.exit(1);
        }
        else if (!thenReturn && elseReturn) {
            System.err.println("Error! Line " + thenLineNum + ": If block does not contain return statement when " +
                    "following else block does!");
            System.exit(1);
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
                System.err.println("Error! Line " + lineNum + ": Function '" + functionName +
                        "' requires return of type " + typeToString(returnType) + ".");
                System.exit(1);
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
                    System.err.println("Error! Line " + lineNum + ": Return type of type '" + typeToString(returnType) +
                            "' does not match declared return type of type '" + typeToString(declaredReturnType) + "'.");
                    System.exit(1);
                }
            }
            else {
//                System.out.println("Null return type");
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
                    System.err.println("Line " + lineNum + ": Incompatible types in assignment! " +
                            leftId + ":" + typeToString(leftType) + " R:" + typeToString(rightType));
                    System.exit(1);
                }
            }
            else {
                System.err.println("LHS of AssignmentStatement is null!");
                System.exit(1);
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
                System.err.println(farLeftName + "is not of type 'struct'!");
                System.exit(1);
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
                System.err.println("Error! Line " + lineNum + ": Function '" +
                        invExpName + "' not previously defined!");
                System.exit(1);
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
                System.err.println("Struct " + structName + " not previously defined!");
                System.exit(1);
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
                    System.err.println("Error! Line " + lineNum + ": Number of arguments do not match number of " +
                            "parameters for function '" + invExpName + "'.");
                    System.exit(1);
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
                                System.err.println("Error! Line " + lineNum + ": Argument " + (i+1) + " of function '" + invExpName +
                                        "' expects argument of type " + typeToString(paramType)
                                        + ", found " + typeToString(argType) + ".");
                                System.exit(1);
                            }
                        }
                        else {
                            System.err.println("Received null return type for argument from getExpressionType()");
                            System.exit(1);
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
            System.err.println("Error! Line " + lineNum + ": Function '" +
                    functionName + "' not previously defined!");
            System.exit(1);
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
                    System.err.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                            "Logical operators require both types to be of type boolean.");
                    System.exit(1);
                }
            }
            else if (opName.equals("EQ") || opName.equals("NE")) {
                //Check that leftType and rightType are same type
                if (!(leftType instanceof IntType || leftType instanceof StructType)) {
                    if (!(leftType.equals(rightType))) {
                        System.err.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                                "Equality operators require types to be of same type integer or struct.");
                        System.exit(1);
                    }
                }
            }
            else {
                //Check that leftType and rightType are both IntType
                if (!(leftType instanceof IntType && rightType instanceof IntType)) {
                    System.err.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                            "Arithmetic and Relational operators require both types to be of type int.");
                    System.exit(1);
                }
            }
        }
        else if (guardExp instanceof TrueExpression || guardExp instanceof FalseExpression) {
            return;
        }
        else if (guardExp instanceof InvocationExpression) {
            InvocationExpression invocation = (InvocationExpression)guardExp;
            Function function = getFunction(invocation.getName(), invocation.getLineNum());
            List<Declaration> params = function.getParams();
            List<Expression> args = invocation.getArguments();
            for (int i = 0; i < args.size(); i++) {
                Expression arg = args.get(i);
                Type argType = getExpressionType(arg, functionName);
                Declaration param = params.get(i);
                Type paramType = param.getType();
                if (!(argType.getClass().equals(paramType.getClass()))) {
                    System.err.println("Error! Line " + invocation.getLineNum() + ": Argument " + (i+1)
                            + " of function '" + invocation.getName() +
                            "' expects argument of type " + typeToString(paramType)
                            + ", found " + typeToString(argType) + ".");
                    System.exit(1);
                }
            }

            Type returnType = function.getRetType();
            if (!(returnType instanceof BoolType)) {
                System.err.println("Error! Function '" + functionName + "' does not have return type of type Boolean!");
                System.exit(1);
            }
        }
        else {
            System.out.println("Unaccounted for expression in checkGuardExpression!");
        }
    }

    private void checkPrintStatement(PrintStatement printStatement, String functionName) {
        Expression expression = printStatement.getExpression();
        Type type = getExpressionType(expression, functionName);

        if (!(type instanceof IntType)) {
            int lineNum = ((AbstractExpression) expression).getLineNum();
            System.err.println("Error! Line " + lineNum + ": Print statement requires integer argument.");
            System.exit(1);
        }
    }

    private void checkPrintLnStatement(PrintLnStatement printLnStatement, String functionName) {
        Expression expression = printLnStatement.getExpression();
        Type type = getExpressionType(expression, functionName);

        if (!(type instanceof IntType)) {
            int lineNum = ((AbstractExpression) expression).getLineNum();
            System.err.println("Error! Line " + lineNum + ": PrintLn statement requires integer argument.");
            System.exit(1);
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
            Function function = getFunction(name, invocationExpression.getLineNum());
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
        else if (expression instanceof NewExpression) {
            NewExpression newExpression = (NewExpression) expression;
            String id = newExpression.getId();

            if (structsMap.containsKey(id)) {
                return new StructType(newExpression.getLineNum(), id);
            }
            else {
                System.err.println("Error! Line " + newExpression.getLineNum() + ": Cannot create struct of type '"
                        + id + "'! Struct not previously defined!");
                System.exit(1);
            }
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
                    System.err.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                            "Logical operators require both types to be of type boolean.");
                    System.exit(1);
                }
                else {
                    return new BoolType();
                }
            }
            else if (opName.equals("EQ") || opName.equals("NE")) {
                //Check that leftType and rightType are same type
                if (!(leftType instanceof IntType || leftType instanceof StructType)) {
                    if (!(leftType.equals(rightType))) {
                        System.err.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                                "Equality operators require types to be of same type integer or struct.");
                        System.exit(1);
                    }
                }
                else {
                    return new BoolType();
                }
            }
            else {
                //Check that leftType and rightType are both IntType
                if (!(leftType instanceof IntType && rightType instanceof IntType)) {
                    System.err.println("Error! Line " + lineNum + ": Incompatible types in conditional guard! " +
                            "Arithmetic and Relational operators require both types to be of type int.");
                    System.exit(1);
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
        else if (expression instanceof ReadExpression) {
            return new IntType();
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

        System.err.println("Error! Cannot find identifier \"" + name + "\"!");
        System.exit(1);

        return null;
    }
}