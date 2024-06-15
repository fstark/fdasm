CFLAGS=-std=c++14 -Wall -Wextra -Werror -pedantic -O3

fdasm: fdasm.o disassembler.o
	g++ ${CFLAGS} fdasm.o disassembler.o -o fdasm

fdasm.o: fdasm.cpp disassembler.h
	g++ -c ${CFLAGS} fdasm.cpp -o fdasm.o

disassembler.o: disassembler.cpp disassembler.h
	g++ -c ${CFLAGS} disassembler.cpp -o disassembler.o

clean:
	rm -f fdasm fdasm.o disassembler.o
