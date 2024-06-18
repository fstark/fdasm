WXCXXFLAGS=$(shell wx-config --cxxflags)
WXLDFLAGS=$(shell wx-config --cxxflags --libs)

# -Wextra -Werror -pedantic 
CXXFLAGS=-std=c++14 -Wall -O3 ${WXCXXFLAGS}
LDFLAGS=-std=c++14 ${WXLDFLAGS}

fdasm: fdasm.o disassembler.o
	g++ fdasm.o disassembler.o -o fdasm ${LDFLAGS}

fdasm.o: fdasm.cpp disassembler.h
	g++ -c ${CXXFLAGS} fdasm.cpp -o fdasm.o

disassembler.o: disassembler.cpp disassembler.h
	g++ -c ${CXXFLAGS} disassembler.cpp -o disassembler.o

clean:
	rm -f fdasm fdasm.o disassembler.o
