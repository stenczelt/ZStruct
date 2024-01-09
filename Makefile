# Use this Makefile with make

# Executable name
CMD = zstruct.exe

# -------- description of DFLAGS ---------------


# -------- Define environmental variable C_COMPILER -----------
# Make sure it is defined
#          ifeq ($(strip$(FORTRAN_COMPILER)),)
# Otherwise you can define it here also by uncommenting next line
FC = icpc -openmp -I$(MKLROOT)/include
# FC = g++ -fopenmp -I$(MKLROOT)/include
DFLAGS =  #-Define the cpp flags to be used
#DFLAGS =  #-Define the cpp flags to be used
OFLAGS =  # optimization

#Intel parallel openmp (only w/icpc compiler)
#LINKERFLAGS =  -L$(MKLROOT)/lib/em64t -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lpthread -lm
LINKERFLAGS =  -L$(MKLROOT)/lib/intel64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lpthread 
# MAC OS linkers
#LINKERFLAGS = -lm -framework Accelerate



#
# Implicit rules for handling src files
#  ( uses static pattern rules, see info for make )
.c.o:
	$(FC) -c -g $(DFLAGS) -Wimplicit $<
.cpp.o:
	$(FC) -c -g $(DFLAGS) $<

OBJECTS = zstruct.o main.o icoord.o pTable.o stringtools.o utils.o mem.o print.o mopac.o dft.o opt.o mm_grad.o lsq.o rxndb.o rxnftr.o atom.o align.o iccomp.o write.o knnr.o rtype.o tm.o nbo.o

$(CMD) : $(OBJECTS)
	$(FC) $(DEBUG_FLAGS) $(OFLAGS) $(LINKERFLAGS) $(OBJECTS)  -o ./$(CMD)

clean:
	/bin/rm -f *.o *.i *.mod *.exe a.out make.log

cleano:
	rm -f *.o *.i

depend :
	g++ -MM *.cpp *.c >> Makefile 

# DO NOT DELETE created with g++ -MM *.cpp *.c
main.o: src/main.cpp include/zstruct.h include/icoord.h include/lsq.h include/rxndb.h include/rxnftr.h include/align.h
lsq.o: src/lsq.cpp include/lsq.h include/utils.h
rxndb.o: src/rxndb.cpp include/rxndb.h include/utils.h include/rxnftr.h include/knnr.h include/rtype.h
rxnftr.o: src/rxnftr.cpp include/rxnftr.h include/utils.h
align.o: src/align.cpp include/align.h include/icoord.h include/utils.h
paths.o: paths.cpp include/zstruct.h include/icoord.h
pgsm.o: pgsm.cpp pgsm.h include/constants.h
dft.o: src/dft.cpp include/dft.h include/constants.h
iso.o: iso.cpp include/zstruct.h include/icoord.h geombasis.h include/constants.h include/utils.h include/mopac.h
atom.o: src/atom.cpp include/atom.h include/icoord.h
zstruct.o: src/zstruct.cpp include/zstruct.h include/utils.h include/constants.h include/print.h include/lsq.h include/rxndb.h include/rxnftr.h include/align.h include/dft.h include/rtype.h include/nbo.h
icoord.o: src/icoord.cpp include/icoord.h include/zstruct.h
mm_grad.o: src/mm_grad.cpp include/icoord.h
mopac.o: src/mopac.cpp include/mopac.h include/constants.h
geombasis.o: geombasis.cpp geombasis.h include/icoord.h
mem.o: src/mem.cpp include/icoord.h
opt.o: src/opt.cpp include/icoord.h
pTable.o: src/pTable.cpp include/pTable.h
print.o: src/print.cpp include/icoord.h
stringtools.o: src/stringtools.cpp include/stringtools.h
utils.o: src/utils.cpp include/utils.h
iccomp.o: src/iccomp.cpp include/zstruct.h include/utils.h
write.o: src/write.cpp include/zstruct.h include/utils.h include/constants.h
knnr.o: src/knnr.cpp include/knnr.h include/utils.h
rtype.o: src/rtype.cpp include/rtype.h include/utils.h include/stringtools.h
tm.o: src/tm.cpp include/zstruct.h include/constants.h
gaussian.o: gaussian.h gaussian.cpp include/constants.h include/utils.h include/stringtools.h include/pTable.h
nbo.o: include/nbo.h src/nbo.cpp include/zstruct.h
