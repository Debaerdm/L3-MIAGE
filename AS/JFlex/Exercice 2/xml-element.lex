import java_cup.runtime.*;

%%
%unicode
%cup
%states INELEMENT

NameStartChar = ":" | [A-Z] | "_" | [a-z] | [\u00C0-\u00D6] | [\u00D8-\u00F6] | [\u00F8-\u002FF] | [\u0370-\u037D] | [\u037F-\u1FFF] | [\u200C-\u200D]| [\u2070-\u218F] | [\u2C00-\u2FEF] | [\u3001-\uD7FF] | [\uF900-\uFDCF] | [\uFDF0-\uFFFD]
NameChar = {NameStartChar} | "-" | "." | [0-9] | \u00B7 | [\u0300-\u036F] | [\u203F-\u2040]
Name = {NameStartChar} ({NameChar})*

CharData = [^<&]* - ([^<&]* ']]>' [^<&]*)
content = CharData? (CharData?)*

%%
  "\n" {}
  "<" {return new Symbol(sym.LT); }
  "</" {return new Symbol(sym.LTSLASH); }
  <INELEMENT>{content} {yybegin(INELEMENT); return new Symbol(sym.CONTENT, yytext()); }
  {Name} {return new Symbol(sym.NAME, yytext()); }
  ">" {return new Symbol(sym.GT); }
  "/>" {return new Symbol(sym.SLASHGT); }
  . {return new Symbol(sym.UNKNOWN); }
