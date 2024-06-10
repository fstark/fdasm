fdasm: fdasm.o disassembler.o
	g++ fdasm.o disassembler.o -o fdasm

fdasm.o: fdasm.cpp disassembler.h
	g++ -c fdasm.cpp -o fdasm.o

disassembler.o: disassembler.cpp disassembler.h
	g++ -c disassembler.cpp -o disassembler.o
