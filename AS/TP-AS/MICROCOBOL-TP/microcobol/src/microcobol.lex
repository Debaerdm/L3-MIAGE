/*
 * Analyseur lexical pour MicroCobol
 * cours d'AS MIAGE
 */

package microcobol;
import java_cup.runtime.Symbol;

%%

%public
%cup
%8bit
%char
%line
%column

%eofval{
	return new Symbol(sym.EOF);
%eofval}

%yylexthrow{
	LexicalException
%yylexthrow}

finligne = \n | \r | \r\n
char = [A-Za-z0-9+\-*/ .,;()']
espace = " "
ident = [a-z]([a-z0-9] | -[a-z0-9]){0,29}
point = "."
quote = \"
chainelitt = {quote} {char}* {quote}
nombrelitt = [+-]? [0-9]* {point}? [0-9]+
/* varniv = [0-4][0-9] | "77" */ /* pas utilise */
impic = [X9/\.]+
pic = "PIC" {espace} {impic}
op = "<" | "=" | ">"

%%
{espace} {}
{finligne} {}
{point} {return new Symbol(sym.POINT);}
{ident} {return new Symbol(sym.IDENT, yytext());}
{chainelitt} {return new Symbol(sym.CHAINE, yytext());}
{nombrelitt} {return new Symbol(sym.NOMBRE, yytext());}
{pic}  {return new Symbol(sym.PIC, yytext());}
{op} {return new Symbol(sym.OP, yytext()); }
"DIVISION" {return new Symbol(sym.DIVISION);}
"SECTION" {return new Symbol(sym.SECTION);}
"IDENTIFICATION" {return new Symbol(sym.IDENTIFICATION);}
"PROGRAM-ID" {return new Symbol(sym.PROGRAMID);}
"DATA" {return new Symbol(sym.DATA);}
"WORKING-STORAGE" {return new Symbol(sym.WS);}
"PROCEDURE" {return new Symbol(sym.PROCEDURE);}
"IF" {return new Symbol(sym.IF);}
"THEN" {return new Symbol(sym.THEN);}
"ELSE" {return new Symbol(sym.ELSE);}
"END-IF" {return new Symbol(sym.ENDIF); }
"IS" {return new Symbol(sym.IS); }
"NOT" {return new Symbol(sym.NOT); }
"END" {return new Symbol(sym.END);}
"PROGRAM" {return new Symbol(sym.PROGRAM);}
"VALUE" {return new Symbol(sym.VALUE);}
"ADD" {return new Symbol(sym.ADD);}
"SUBSTRACT" {return new Symbol(sym.SUBSTRACT);}
"MULTIPLY" {return new Symbol(sym.MULTIPLY);}
"DIVIDE" {return new Symbol(sym.DIVIDE);}
"TO" {return new Symbol(sym.TO);}
"GIVING" {return new Symbol(sym.GIVING);}
"FROM" {return new Symbol(sym.FROM);}
"MOVE" {return new Symbol(sym.MOVE);}
"DISPLAY" {return new Symbol(sym.DISPLAY);}
"RUN" {return new Symbol(sym.RUN);}
"STOP" {return new Symbol(sym.STOP);}

