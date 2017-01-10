public class Syntax{

    private Lexico lex ; // analyseur lexical 
    private int leToken ; // dernier token lu

    /* les constructeurs : on peut faire l'analyse à partir d'un fichier 
       ou de l'entrée standard.
    */
    public Syntax(String nomFichier) throws java.io.FileNotFoundException, 
					    java.io.IOException{
	lex = new Lexico(nomFichier);
	lireLeToken() ;
    }

    public Syntax() throws java.io.IOException{// lecture sur l'entrée standard
	lex = new Lexico() ;
	lireLeToken() ;
    }

    /* gestion des erreurs */
    private void erreur(String pb) throws SyntaxException{
	throw new SyntaxException(pb + " : ligne " + lex.numeroLigne() + "[dernier token :"+
				  lex.image(leToken)+"]") ;
    }

    private void verifierToken(int tokenAttendu) throws SyntaxException{
	if (leToken != tokenAttendu) 
	    erreur(lex.image(tokenAttendu) + " token attendu") ;
    }  

    /* les fins de lignes et fin de fichier */
    private void passerLignes() throws java.io.IOException{
	while (leToken == Lexico.TOKEN_EOL) leToken = lex.nextToken() ;
    }

    private boolean finFichier() {
	return (leToken == Lexico.TOKEN_EOF) ;
    }

    /* lire le token suivant : modifie la variable d'instance leToken */
    private void lireLeToken() throws java.io.IOException{leToken = lex.nextToken() ; }

    /* ---------------------------------------- */
    /* analyse syntaxique récursive descendante */
    /* ---------------------------------------- */
    private void expression() throws SyntaxException, java.io.IOException{
	/* expression -> terme suiteExpression */
        terme();
        suiteExpression();
    }

    private void terme() throws SyntaxException, java.io.IOException {
        /*terme -> facteur suiteTerme*/
        facteur();
        suiteTerme();
    }

    private void facteur() throws SyntaxException, java.io.IOException {
        /*facteur -> ( expression ) | atome*/
        lireLeToken();
        if(leToken == Lexico.TOKEN_PAR_OUV) {
            expression();
            lireLeToken();
            verifierToken(Lexico.TOKEN_PAR_FER);
        } else {
            atome();
        }
    }

    private void suiteTerme() throws SyntaxException, java.io.IOException {
        /*suiteTerme -> * facteur suiteTerme | / facteur suiteTerme | E*/
        lireLeToken();
        if(leToken == Lexico.TOKEN_MULT || leToken == Lexico.TOKEN_DIV) {
            facteur();
            suiteTerme();
        }
    }

    private void suiteExpression() throws SyntaxException, java.io.IOException {
        /*suiteExpression -> + terme suiteExpression | - term suiteExpression | E*/
        lireLeToken();
        if(leToken == Lexico.TOKEN_PLUS || leToken == Lexico.TOKEN_MOINS) {
            terme();
            suiteExpression();
        }
    }

    private void atome() throws SyntaxException, java.io.IOException {
        /* atome -> identif | entier | - identif | - entier */
        lireLeToken();
        if(leToken == Lexico.TOKEN_MOINS) {
            verifierToken(Lexico.TOKEN_MOINS);
            lireLeToken();
            atomeBis();
        } else {
            atomeBis();
        }
    }

    private void atomeBis() throws SyntaxException, java.io.IOException {
        if(leToken == Lexico.TOKEN_IDENTIF) {
            verifierToken(Lexico.TOKEN_IDENTIF);
        } 

        if(leToken == Lexico.TOKEN_ENTIER) {
            verifierToken(Lexico.TOKEN_ENTIER);
        }
    }

    /* la seule méthode d'instance qui soit publique */
    public void analyse() throws SyntaxException, java.io.IOException{
	passerLignes() ;
	while (! finFichier()){
	    expression() ;
	    verifierToken(Lexico.TOKEN_EOL) ; passerLignes() ;
	}
    }

    public static void main(String args[]) throws Exception{
	Syntax synt ;
	if (args.length == 0) synt = new Syntax() ;
        else synt = new Syntax(args[0]) ;
 
	synt.analyse() ;
    }
}
