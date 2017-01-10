# Makefile
##############################################################################
# $Id: Makefile,v 1.1.1.1 2004/02/24 21:40:03 sedoglav Exp $
##############################################################################
#

# 
# Définitions générales 
#
#CC=
CFLAGS=-g 
RM=/bin/rm -f 

CIBLES= shell ffs mkbadbloc
BIBS= tp.o erreurs.o volume.o fs.o fichier.o 

#
# Tout reconstruire 
#
.PHONY : all
all : $(CIBLES)

#
# Les executables 
#
shell : $(BIBS) shell.o
	$(CC) $(CFLAGS) -o shell $(BIBS) shell.o 
ffs : $(BIBS) ffs.o
	$(CC) $(CFLAGS) -o ffs $(BIBS) ffs.o
mkbadbloc : $(BIBS) mkbadbloc.o
	$(CC) $(CFLAGS) -o mkbadbloc $(BIBS) mkbadbloc.o

#
# Les objets 
#
tp.o : erreurs.h nombres.h volume.h repertoire.h fs.h fichier.h
erreurs.o : erreurs.h
volume.o : erreurs.h nombres.h volume.h
fs.o : erreurs.h nombres.h volume.h repertoire.h fs.h
fichier.o : erreurs.h nombres.h volume.h repertoire.h fs.h fichier.h
ffs.o : erreurs.h nombres.h volume.h repertoire.h fs.h fichier.h
shell.o : erreurs.h nombres.h volume.h repertoire.h fs.h fichier.h
mkbadbloc.o : erreurs.h nombres.h volume.h repertoire.h fs.h fichier.h

#
# Misc. 
#
badbloc : mkbadbloc
	./mkbadbloc

.PHONY : clean realclean
clean : 
	$(RM) *.o
realclean : clean 
	$(RM) $(CIBLES)
	$(RM) badbloc
