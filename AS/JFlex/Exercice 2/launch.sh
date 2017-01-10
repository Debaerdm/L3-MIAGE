#!/bin/bash

java -cp /usr/share/java/JFlex.jar JFlex.Main ./xml-element.lex;
javac -cp /usr/share/java/cup.jar *.java;
java -cp /usr/share/java/cup.jar:. XmlScan cdcatalog.xml
