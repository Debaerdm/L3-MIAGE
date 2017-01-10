/* Expr.java */
/* Generated By:JavaCC: Do not edit this line. Expr.java */
/** Expressions arithmetiques. */
public class Expr implements ExprConstants {

  /** Main entry point. */
  public static void main(String args[]) throws ParseException {
    Expr parser = new Expr(System.in);
    parser.listeExpression();
  }

//<VALUE_STATE> TOKEN : {<TOKEN_LET: "let">: DEFAULT}

/** Root production. */
  static final public 
void listeExpression() throws ParseException {
    trace_call("listeExpression");
    try {
      label_1:
      while (true) {
        switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
        case TOKEN_ENTIER:
        case TOKEN_LET:
        case TOKEN_IDENTIF:
        case TOKEN_EOL:
        case TOKEN_PAR_OUV:
        case TOKEN_MOINS:{
          ;
          break;
          }
        default:
          jj_la1[0] = jj_gen;
          break label_1;
        }
        switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
        case TOKEN_ENTIER:
        case TOKEN_IDENTIF:
        case TOKEN_PAR_OUV:
        case TOKEN_MOINS:{
          expression();
          jj_consume_token(TOKEN_EOL);
          break;
          }
        case TOKEN_LET:
        case TOKEN_EOL:{
          listeAffExpr();
          jj_consume_token(TOKEN_EOL);
          break;
          }
        default:
          jj_la1[1] = jj_gen;
          jj_consume_token(-1);
          throw new ParseException();
        }
      }
      jj_consume_token(0);
    } finally {
      trace_return("listeExpression");
    }
  }

  static final public void expression() throws ParseException {
    trace_call("expression");
    try {
      terme();
      suiteExpression();
System.out.println("Expression Ok.");
    } finally {
      trace_return("expression");
    }
  }

  static final public void terme() throws ParseException {
    trace_call("terme");
    try {
      facteur();
      suiteTerme();
    } finally {
      trace_return("terme");
    }
  }

  static final public void suiteExpression() throws ParseException {
    trace_call("suiteExpression");
    try {
      switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
      case TOKEN_PLUS:{
        jj_consume_token(TOKEN_PLUS);
        terme();
        suiteExpression();
        break;
        }
      case TOKEN_MOINS:{
        jj_consume_token(TOKEN_MOINS);
        terme();
        suiteExpression();
        break;
        }
      default:
        jj_la1[2] = jj_gen;

      }
    } finally {
      trace_return("suiteExpression");
    }
  }

  static final public void suiteTerme() throws ParseException {
    trace_call("suiteTerme");
    try {
      switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
      case TOKEN_MULT:{
        jj_consume_token(TOKEN_MULT);
        facteur();
        suiteTerme();
        break;
        }
      case TOKEN_DIV:{
        jj_consume_token(TOKEN_DIV);
        facteur();
        suiteTerme();
        break;
        }
      default:
        jj_la1[3] = jj_gen;

      }
    } finally {
      trace_return("suiteTerme");
    }
  }

  static final public void facteur() throws ParseException {
    trace_call("facteur");
    try {
      switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
      case TOKEN_PAR_OUV:{
        jj_consume_token(TOKEN_PAR_OUV);
        expression();
        jj_consume_token(TOKEN_PAR_FER);
        break;
        }
      case TOKEN_ENTIER:
      case TOKEN_IDENTIF:
      case TOKEN_MOINS:{
        atome();
        break;
        }
      default:
        jj_la1[4] = jj_gen;
        jj_consume_token(-1);
        throw new ParseException();
      }
    } finally {
      trace_return("facteur");
    }
  }

  static final public void atome() throws ParseException {
    trace_call("atome");
    try {
      switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
      case TOKEN_MOINS:{
        jj_consume_token(TOKEN_MOINS);
        valeur();
        break;
        }
      case TOKEN_ENTIER:
      case TOKEN_IDENTIF:{
        valeur();
        break;
        }
      default:
        jj_la1[5] = jj_gen;
        jj_consume_token(-1);
        throw new ParseException();
      }
    } finally {
      trace_return("atome");
    }
  }

  static final public void valeur() throws ParseException {
    trace_call("valeur");
    try {
      switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
      case TOKEN_IDENTIF:{
        jj_consume_token(TOKEN_IDENTIF);
        break;
        }
      case TOKEN_ENTIER:{
        jj_consume_token(TOKEN_ENTIER);
        break;
        }
      default:
        jj_la1[6] = jj_gen;
        jj_consume_token(-1);
        throw new ParseException();
      }
    } finally {
      trace_return("valeur");
    }
  }

  static final public void listeAffExpr() throws ParseException {
    trace_call("listeAffExpr");
    try {
      switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
      case TOKEN_ENTIER:
      case TOKEN_LET:
      case TOKEN_IDENTIF:
      case TOKEN_PAR_OUV:
      case TOKEN_MOINS:{
        AffExpr();
        listeAffExpr();
        break;
        }
      default:
        jj_la1[7] = jj_gen;

      }
    } finally {
      trace_return("listeAffExpr");
    }
  }

  static final public void AffExpr() throws ParseException {
    trace_call("AffExpr");
    try {
      switch ((jj_ntk==-1)?jj_ntk_f():jj_ntk) {
      case TOKEN_ENTIER:
      case TOKEN_IDENTIF:
      case TOKEN_PAR_OUV:
      case TOKEN_MOINS:{
        expression();
        break;
        }
      case TOKEN_LET:{
        affectation();
        break;
        }
      default:
        jj_la1[8] = jj_gen;
        jj_consume_token(-1);
        throw new ParseException();
      }
    } finally {
      trace_return("AffExpr");
    }
  }

  static final public void affectation() throws ParseException {
    trace_call("affectation");
    try {
      jj_consume_token(TOKEN_LET);
      jj_consume_token(TOKEN_IDENTIF);
      jj_consume_token(TOKEN_EQUAL);
      expression();
    } finally {
      trace_return("affectation");
    }
  }

  static private boolean jj_initialized_once = false;
  /** Generated Token Manager. */
  static public ExprTokenManager token_source;
  static SimpleCharStream jj_input_stream;
  /** Current token. */
  static public Token token;
  /** Next token. */
  static public Token jj_nt;
  static private int jj_ntk;
  static private int jj_gen;
  static final private int[] jj_la1 = new int[9];
  static private int[] jj_la1_0;
  static {
      jj_la1_init_0();
   }
   private static void jj_la1_init_0() {
      jj_la1_0 = new int[] {0x4f8,0x4f8,0x600,0x1800,0x4a8,0x428,0x28,0x4b8,0x4b8,};
   }

  /** Constructor with InputStream. */
  public Expr(java.io.InputStream stream) {
     this(stream, null);
  }
  /** Constructor with InputStream and supplied encoding */
  public Expr(java.io.InputStream stream, String encoding) {
    if (jj_initialized_once) {
      System.out.println("ERROR: Second call to constructor of static parser.  ");
      System.out.println("       You must either use ReInit() or set the JavaCC option STATIC to false");
      System.out.println("       during parser generation.");
      throw new Error();
    }
    jj_initialized_once = true;
    try { jj_input_stream = new SimpleCharStream(stream, encoding, 1, 1); } catch(java.io.UnsupportedEncodingException e) { throw new RuntimeException(e); }
    token_source = new ExprTokenManager(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 9; i++) jj_la1[i] = -1;
  }

  /** Reinitialise. */
  static public void ReInit(java.io.InputStream stream) {
     ReInit(stream, null);
  }
  /** Reinitialise. */
  static public void ReInit(java.io.InputStream stream, String encoding) {
    try { jj_input_stream.ReInit(stream, encoding, 1, 1); } catch(java.io.UnsupportedEncodingException e) { throw new RuntimeException(e); }
    token_source.ReInit(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 9; i++) jj_la1[i] = -1;
  }

  /** Constructor. */
  public Expr(java.io.Reader stream) {
    if (jj_initialized_once) {
      System.out.println("ERROR: Second call to constructor of static parser. ");
      System.out.println("       You must either use ReInit() or set the JavaCC option STATIC to false");
      System.out.println("       during parser generation.");
      throw new Error();
    }
    jj_initialized_once = true;
    jj_input_stream = new SimpleCharStream(stream, 1, 1);
    token_source = new ExprTokenManager(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 9; i++) jj_la1[i] = -1;
  }

  /** Reinitialise. */
  static public void ReInit(java.io.Reader stream) {
    jj_input_stream.ReInit(stream, 1, 1);
    token_source.ReInit(jj_input_stream);
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 9; i++) jj_la1[i] = -1;
  }

  /** Constructor with generated Token Manager. */
  public Expr(ExprTokenManager tm) {
    if (jj_initialized_once) {
      System.out.println("ERROR: Second call to constructor of static parser. ");
      System.out.println("       You must either use ReInit() or set the JavaCC option STATIC to false");
      System.out.println("       during parser generation.");
      throw new Error();
    }
    jj_initialized_once = true;
    token_source = tm;
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 9; i++) jj_la1[i] = -1;
  }

  /** Reinitialise. */
  public void ReInit(ExprTokenManager tm) {
    token_source = tm;
    token = new Token();
    jj_ntk = -1;
    jj_gen = 0;
    for (int i = 0; i < 9; i++) jj_la1[i] = -1;
  }

  static private Token jj_consume_token(int kind) throws ParseException {
    Token oldToken;
    if ((oldToken = token).next != null) token = token.next;
    else token = token.next = token_source.getNextToken();
    jj_ntk = -1;
    if (token.kind == kind) {
      jj_gen++;
      trace_token(token, "");
      return token;
    }
    token = oldToken;
    jj_kind = kind;
    throw generateParseException();
  }


/** Get the next Token. */
  static final public Token getNextToken() {
    if (token.next != null) token = token.next;
    else token = token.next = token_source.getNextToken();
    jj_ntk = -1;
    jj_gen++;
      trace_token(token, " (in getNextToken)");
    return token;
  }

/** Get the specific Token. */
  static final public Token getToken(int index) {
    Token t = token;
    for (int i = 0; i < index; i++) {
      if (t.next != null) t = t.next;
      else t = t.next = token_source.getNextToken();
    }
    return t;
  }

  static private int jj_ntk_f() {
    if ((jj_nt=token.next) == null)
      return (jj_ntk = (token.next=token_source.getNextToken()).kind);
    else
      return (jj_ntk = jj_nt.kind);
  }

  static private java.util.List<int[]> jj_expentries = new java.util.ArrayList<int[]>();
  static private int[] jj_expentry;
  static private int jj_kind = -1;

  /** Generate ParseException. */
  static public ParseException generateParseException() {
    jj_expentries.clear();
    boolean[] la1tokens = new boolean[22];
    if (jj_kind >= 0) {
      la1tokens[jj_kind] = true;
      jj_kind = -1;
    }
    for (int i = 0; i < 9; i++) {
      if (jj_la1[i] == jj_gen) {
        for (int j = 0; j < 32; j++) {
          if ((jj_la1_0[i] & (1<<j)) != 0) {
            la1tokens[j] = true;
          }
        }
      }
    }
    for (int i = 0; i < 22; i++) {
      if (la1tokens[i]) {
        jj_expentry = new int[1];
        jj_expentry[0] = i;
        jj_expentries.add(jj_expentry);
      }
    }
    int[][] exptokseq = new int[jj_expentries.size()][];
    for (int i = 0; i < jj_expentries.size(); i++) {
      exptokseq[i] = jj_expentries.get(i);
    }
    return new ParseException(token, exptokseq, tokenImage);
  }

  static private int trace_indent = 0;
  static private boolean trace_enabled = true;

/** Enable tracing. */
  static final public void enable_tracing() {
    trace_enabled = true;
  }

/** Disable tracing. */
  static final public void disable_tracing() {
    trace_enabled = false;
  }

  static private void trace_call(String s) {
    if (trace_enabled) {
      for (int i = 0; i < trace_indent; i++) { System.out.print(" "); }
      System.out.println("Call:   " + s);
    }
    trace_indent = trace_indent + 2;
  }

  static private void trace_return(String s) {
    trace_indent = trace_indent - 2;
    if (trace_enabled) {
      for (int i = 0; i < trace_indent; i++) { System.out.print(" "); }
      System.out.println("Return: " + s);
    }
  }

  static private void trace_token(Token t, String where) {
    if (trace_enabled) {
      for (int i = 0; i < trace_indent; i++) { System.out.print(" "); }
      System.out.print("Consumed token: <" + tokenImage[t.kind]);
      if (t.kind != 0 && !tokenImage[t.kind].equals("\"" + t.image + "\"")) {
        System.out.print(": \"" + t.image + "\"");
      }
      System.out.println(" at line " + t.beginLine + " column " + t.beginColumn + ">" + where);
    }
  }

  static private void trace_scan(Token t1, int t2) {
    if (trace_enabled) {
      for (int i = 0; i < trace_indent; i++) { System.out.print(" "); }
      System.out.print("Visited token: <" + tokenImage[t1.kind]);
      if (t1.kind != 0 && !tokenImage[t1.kind].equals("\"" + t1.image + "\"")) {
        System.out.print(": \"" + t1.image + "\"");
      }
      System.out.println(" at line " + t1.beginLine + " column " + t1.beginColumn + ">; Expected token: <" + tokenImage[t2] + ">");
    }
  }

}