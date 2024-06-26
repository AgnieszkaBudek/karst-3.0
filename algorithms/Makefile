UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
    CC		= clang
    CXX 	= clang++
    FL		= gfortran
    MDIR	=  ~/.nix-profile/opt/mumps
    FLIBS	= -L ~/.nix-profile/lib -lgfortran -lquadmath -lblas
else
    # Pobierz wersję macOS
    MACOS_VERSION := $(shell sw_vers -productVersion)

    # Sprawdź wersję i ustaw odpowiedni kompilator CXX

    ifeq ($(shell echo "$(MACOS_VERSION) >= 12.15" | bc), 1)
        CC      = /opt/homebrew/bin/gcc-13
        CXX 	= /opt/homebrew/bin/g++-13
        FL      = /opt/homebrew/bin/gfortran
        MDIR	= ~/Desktop/KARST/MUMPS_5.6.0
        FLIBS	= -L/opt/homebrew/lib -L/opt/homebrew/Cellar/gcc/12.2.0/lib/gcc/12 -lblas -llapack -lesmumps -lscotch -lscotcherr -lmumps_common -lmetis -lgomp -lgfortran
    else
        CC      = clang
        CXX 	= clang++
        FL      = gfortran
        MDIR	= /Users/agnieszka/Desktop/KARST/MUMPS_4.7.3
        FLIBS	= -lgfortran -lquadmath -lblas
    endif
endif

AR      = ar vr 


COPTS	= -Wall -pedantic -O2 
MINCLUDES	= -I $(MDIR)/include -I $(MDIR)/libseq 

CFLAGS	= $(COPTS) $(MINCLUDES) 


OBJ	= matrix_solvers.o triangularization.o main.o
INC	= algorithms.h 


LINKOPTS = $(COPTS)
MLIBS	= -lm -ldmumps -lmpiseq -lpthread -lpord -lstdc++  $(FLIBS)
MFLAGS	= $(LINKOPTS) $(MLIBS) -L $(MDIR)/lib -L $(MDIR)/libseq
CXXFLAGS= -std=c++11 -Weffc++ -Wall -Wextra -Wfatal-errors -Wunused -pedantic -w -Winline 
TMP     = -fno-rtti -ggdb -D_GLIBCXX_DEBUG -lsfml-graphics -lsfml-window -lsfml-system

#
## Default target
#.DEFAULT:
#    @echo "No target specified. To build a program, use: make <program_name>"


.cc.o: 
	$(CXX) $(CXXFLAGS) -c $< 

.c.o: 
	$(CC) $(CFLAGS) -c $< 


algorithms: $(OBJ)	
#	$(FL) -o ../bin/algorithms $^ $(MFLAGS)
	$(AR) libalgorithms.a matrix_solvers.o triangularization.o
	$(CXX) -o ../bin/algorithms $^ $(MFLAGS)  $(CXXFLAGS)


clean:
	rm -f *.o *.a


all: 
	mkdir -p ../bin
	make algorithms
