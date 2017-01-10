#!/bin/bash

java -cp ../jflex-1.6.1/jflex-1.6.1.jar jflex/Main ./lexiArithm.lex;
javac -cp ../jflex-1.6.1/java-cup-11a.jar *.java;
java -cp ../jflex-1.6.1/java-cup-11a.jar:. TestLexiArithm ./entreeTest.txt
