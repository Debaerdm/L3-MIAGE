# Makefile
##############################################################################
# $Id: Makefile,v 1.1 1999-07-16 15:39:27 marquet Exp $
##############################################################################
#

# 
# Définitions générales 
#
#CC=
CFLAGS=-g
RM=/bin/rm -f 

CIBLES= shell ffs
BIBS= erreurs.o volume.o fs.o fstp.o fichier.o 

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

#
# Les objets 
#
erreurs.o : erreurs.h
volume.o : erreurs.h nombres.h volume.h
fs.o : erreurs.h nombres.h volume.h repertoire.h fs.h
fstp.o : erreurs.h nombres.h volume.h repertoire.h fs.h
fichier.o : erreurs.h nombres.h volume.h repertoire.h fs.h fichier.h
ffs.o : erreurs.h nombres.h volume.h repertoire.h fs.h fichier.h
shell.o : erreurs.h nombres.h volume.h repertoire.h fs.h fichier.h

#
# Misc. 
#
.PHONY : clean realclean
clean : 
	$(RM) *.o
realclean : clean 
	$(RM) $(CIBLES)
