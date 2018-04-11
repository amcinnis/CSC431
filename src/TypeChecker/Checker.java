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
      /* Create global declaration table
         Create struct table
         Create function table
         iterate through types
         iterate through decls
         iterate through funcs
       */

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
        }

        //Check for main function
        if (!functionsMap.containsKey("main")) {
            System.out.println("Error: Program is missing main method!");
        }
    }
}