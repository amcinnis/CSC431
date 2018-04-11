#!/bin/bash
echo "java -cp $CLASSPATH org.antlr.v4.Tool -visitor src/Mini.g4"
java -cp $CLASSPATH org.antlr.v4.Tool -visitor src/Mini.g4
echo "touch src/antlr.generated"
touch src/antlr.generated
