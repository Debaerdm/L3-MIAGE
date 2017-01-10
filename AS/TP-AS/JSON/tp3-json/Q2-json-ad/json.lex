import java_cup.runtime.* ;

%%

%cup
%unicode
%char
%line
%column
%public
 
%yylexthrow{
  LexicalException
%yylexthrow}

%{
  public int line() { return yyline; }
  public int col() { return yycolumn; }
  public int charpos() { return yychar; }
%}

 /* JFlex Macro-definitions */
ws = (\u0020 | \u0009 | \u000A | \u000D)*
begin_array  = {ws} \u005B {ws}
begin_object = {ws} \u007B {ws}
end_array    = {ws} \u005D {ws}
end_object = {ws} \u007D {ws}
name_separator = {ws} \u003A {ws}
value_separator = {ws} \u002C {ws} 
false = false
null = null
true = true
number = ({minus})? {int} ({frac})? ({exp})?
decimal_point = \u002E
digit_9 = [\u0031-\u0039]
e = (\u0065 | \u0045)
exp = {e} ({minus} | {plus})? ({DIGIT})+
frac = {decimal_point} {DIGIT}+
int = {zero} | ({digit_9} {DIGIT}*)
minus = \u002D
plus = \u002B
zero = \u0030
string = {quotation_mark} ({char})* {quotation_mark}
char = {unescaped} | {escape} (\u0022 | \u005C | \u002F | \u0062 | \u0066 | \u006E | \u0072 | \u0074 | \u0075 ({HEXDIG}){4})
escape = \u005C
quotation_mark = \u0022
unescaped = [\u0020-\u0021] | [\u0023-\u005B] | [\u005D-\uFFFF]
DIGIT = [0-9]
HEXDIG = {DIGIT} | "A" | "B" | "C" | "D" | "E" | "F"

%% 
{begin_array} {return new Symbol(sym.BEGINARRAY);}
{end_array} {return new Symbol(sym.ENDARRAY);}
{begin_object} {return new Symbol(sym.BEGINOBJECT);}
{end_object} {return new Symbol(sym.ENDOBJECT);}
{name_separator} {return new Symbol(sym.NAMESEPARATOR);}
{value_separator} {return new Symbol(sym.VALUESEPARATOR);}
{false} {return new Symbol(sym.FALSE);}
{null} {return new Symbol(sym.NULL);}
{true} {return new Symbol(sym.TRUE);}
{number} {return new Symbol(sym.NUMBER);}
{string} {return new Symbol(sym.STRING);}


. {throw new LexicalException("token inconnu : "+yytext()+ " at line "+yyline+ ", col " +yycolumn);}
