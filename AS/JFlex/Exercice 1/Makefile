JC:javac
JAVA:java
JFLEX:jFlex
CUP:/usr/share/java/cup.jar
FLAGS:-cp
LEX:Yylex.java
JAVAFILES:$(wildcard *.java)

.PHONY:$(LEX) bordel test clean 

$(LEX) : lexiArithm.lex
	$(JFLEX) lexiArithm.lex

bordel: $(JAVAFiLES) 
	$(JC) $(FLAGS) $(CUP) $<

test:


clean:
	$(rm) *.class
	@echo "Cleanup complete!"
