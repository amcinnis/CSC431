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

        //TODO Check to see if need to differentiate between types
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
            }
        }

        //Check for main function
        if (!functionsMap.containsKey("main")) {
            System.out.println("Error: Program is missing main method!");
        }
    }

    private void checkBlockStatement(BlockStatement block, String functionName) {
        List <Statement> statements = block.getStatements();

        for (Statement statement : statements) {
            //Invocation
            if (statement instanceof InvocationStatement) {
                InvocationStatement invocation = (InvocationStatement) statement;
                checkInvocationStatement(invocation);
            }
            //Conditional
            else if (statement instanceof ConditionalStatement) {
                ConditionalStatement conditional = (ConditionalStatement) statement;
                checkConditionalStatement(conditional, functionName);
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
            lineNum = top.getLineNum();
            leftId = top.getId();

            Type leftStructType = getLValueDotType(top.getLeft(), leftId, functionName);
            leftType = getStructFieldType(leftStructType, leftId);
        }

        if (rightType != null) {
            if (!(leftType.getClass().equals(rightType.getClass()))) {
                System.out.println("Line " + lineNum + ": Incompatible types in assignment! " +
                        leftId + ":" + typeToString(leftType) + " R:" + typeToString(rightType));
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

    private Type getLValueDotType(Expression left, String id, String functionName) {
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
        else if (left instanceof DotExpression) {
            DotExpression leftExp = (DotExpression) left;
            Expression nextExp = leftExp.getLeft();
            String nextId = leftExp.getId();

            Type leftType = getLValueDotType(nextExp, nextId, functionName);
            Type fieldType = getStructFieldType(leftType, nextId);

            return fieldType;
        }

        return null;
    }

    private Type getStructFieldType(Type leftType, String id) {
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
                System.out.println("Struct " + struct.getName() + " does not contain a field named: '" + id + "'!");
            } else {
                System.out.println("Struct " + structName + " not previously defined!");
            }
        }
        else {
            System.out.println("Incorrect type passed to getStructFieldType");
        }

        return null;
    }

    private void checkInvocationStatement(InvocationStatement invocation) {
        Expression expression = invocation.getExpression();
        if (expression instanceof InvocationExpression) {
            String invExpName = ((InvocationExpression) expression).getName();
            if (!(functionsMap.containsKey(invExpName))) {
                System.out.println("Error: Function \"" + invExpName + "\" not previously defined!");
            }
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

    private void checkGuardExpression(Expression guardExp, String functionName) {
        if (guardExp instanceof BinaryExpression) {
            BinaryExpression guard = (BinaryExpression) guardExp;

            BinaryExpression.Operator operator = guard.getOperator();
            String opName = operator.name();

            Expression left = guard.getLeft();
            Expression right = guard.getRight();

            Type leftType = getExpressionType(left, functionName);
            Type rightType = getExpressionType(right, functionName);

            if (opName.equals("AND") || opName.equals("OR")) {
                //Check that leftType and rightType are both BoolType
                if (!(leftType instanceof BoolType && rightType instanceof BoolType)) {
                    System.out.println("Error: Incompatible types in conditional guard! " +
                            "Logical operators require both types to be of type boolean.");
                }
            }
            else if (opName.equals("EQ") || opName.equals("NE")) {
                //Check that leftType and rightType are same type
                if (!(leftType.equals(rightType))) {
                    System.out.println("Error: Incompatible types in conditional guard! " +
                            "Equality operators require both types to be of same type.");
                }
            }
            else {
                //Check that leftType and rightType are both IntType
                if (!(leftType instanceof IntType && rightType instanceof IntType)) {
                    System.out.println("Error: Incompatible types in conditional guard! " +
                            "Arithmetic operators require both types to be of type int.");
                }
            }
        }
        else {
            System.out.println("Non Binary expression in guard of Conditional");
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
            if (functionsMap.containsKey(name)) {
                Function function = (Function) functionsMap.get(name);
                return function.getRetType();
            }
            else {
                System.out.println("Cannot find function \"" + name + "\" in functions list!");
            }
        }
        else if (expression instanceof IdentifierExpression) {
            IdentifierExpression identifierExpression = (IdentifierExpression) expression;
            String name = identifierExpression.getId();

            return getIdentifierType(name, functionName);
        }
        else if (expression instanceof NullExpression) {
            return null;
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

        System.out.println("Cannot find identifier \"" + name + "\"!");

        return null;
    }
}