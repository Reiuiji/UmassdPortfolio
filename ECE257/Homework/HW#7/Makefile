#make for HW7
#Daniel Noyes <dnoyes@umassd.edu>
CC = gcc
RM = rm -rf
CFLAGS = -lm
Home = $(abspath .)
BuildDir = ${Home}/Build
BuildOBJ = ${CC} ${CFLAGS} -c $< -o ${BuildDir}/$@

all: HW7

HW7: setup main.o sine.o squareroot.o square.o squaresum.o
	${CC} ${CFLAGS} -o HW7-build ${BuildDir}/{main.o,sine.o,squareroot.o,square.o,squaresum.o}

main.o: main.c
	${BuildOBJ}

sine.o: sine.c 
	${BuildOBJ}

sine: setup sine.o
	${CC} ${CFLAGS} -c mainSin.c -o ${BuildDir}/mainSin.o
	${CC} ${CFLAGS} -o HW7-build-Sine ${BuildDir}/{mainSin.o,sine.o}

squareroot.o: squareroot.c
	${BuildOBJ}

squareroot: setup squareroot.o
	${CC} ${CFLAGS} -c mainSqrt.c -o ${BuildDir}/mainSqrt.o
	${CC} ${CFLAGS} -o HW7-build-squareroot ${BuildDir}/{mainSqrt.o,squareroot.o}

square.o: square.c
	${BuildOBJ}

square: setup square.o
	${CC} ${CFLAGS} -c mainSq.c -o ${BuildDir}/mainSq.o
	${CC} ${CFLAGS} -o HW7-build-square ${BuildDir}/{mainSq.o,square.o}

squaresum.o: squaresum.c 
	${BuildOBJ}

squaresum: setup squaresum.o
	${CC} ${CFLAGS} -c mainSqsum.c -o ${BuildDir}/mainSqsum.o
	${CC} ${CFLAGS} -o HW7-build-squaresum ${BuildDir}/{mainSqsum.o,squaresum.o}

clean:
	rm -rf ${BuildDir}
	rm -f HW7-build*
setup:
	mkdir -p ${BuildDir}
