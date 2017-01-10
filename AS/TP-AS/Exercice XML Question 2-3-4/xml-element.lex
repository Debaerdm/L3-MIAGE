import java_cup.runtime.*;

%%
%unicode
%cup
%states INELEMENT, ATTRIBUTE

NameStartChar = ":" | [A-Z] | "_" | [a-z] | [\u00C0-\u00D6] | [\u00D8-\u00F6] | [\u00F8-\u02FF] | [\u0370-\u037D] | [\u037F-\u1FFF] | [\u200C-\u200D]| [\u2070-\u218F] | [\u2C00-\u2FEF] | [\u3001-\uD7FF] | [\uF900-\uFDCF] | [\uFDF0-\uFFFD]
NameChar = {NameStartChar} | "-" | "." | [0-9] | \u00B7 | [\u0300-\u036F] | [\u203F-\u2040]
Name = {NameStartChar} ({NameChar})*

Eq = S? "=" S?
EntityRef = "&" {Name} ";"
CharRef = "&#" [0-9]+ ";" | "&#x" [0-9a-fA-F]+ ";"
Reference = {EntityRef} | {CharRef}
AttValue = "\"" ([^<&"\""] | {Reference})* "\"" | "'" ([^<&'] | {Reference})* "'"
Attribute = {Name} {Eq} {AttValue}

A = [^<&]*
B = ([^<&]* ']]>' [^<&]*)
CharData = !(!{A} | {B})
content = {CharData}? ({CharData}?)*

%%
  "\n" {}
  "<" {return new Symbol(sym.LT); }
  "</" {return new Symbol(sym.LTSLASH); }
  <ATTRIBUTE> {Attribute} {return new Symbol(sym.ATTRIBUT, yytext());}
  <INELEMENT> {content} {return new Symbol(sym.CONTENT, yytext()); }
  {Name} {return new Symbol(sym.NAME, yytext()); }
  ">" {return new Symbol(sym.GT); }
  "/>" {return new Symbol(sym.SLASHGT); }
  . {return new Symbol(sym.UNKNOWN); }
