#!/bin/shell

java -cp /usr/share/java/JFlex.jar JFlex.Main lexiArithm.lex;
java -cp /usr/share/java/cup.jar java_cup.Main < ExprArithmAttr.cup;
javac -cp /usr/share/java/cup.jar LexicalException.java sym.java Yylex.java parser.java TestExprArithm.java;
java -cp /usr/share/java/cup.jar:. TestExprArithm entreeTest.txt
