# -Wextra -Werror -pedantic 
# CXXFLAGS=-std=c++14 -Wall -O3
CXXFLAGS=-g -std=c++14 -Wall -O0 -I external/imgui
LDFLAGS=-std=c++14 -lSDL2 -lSDL2_image -framework OpenGL

test: fdasm
	./fdasm M100rom.bin M100rom.fda > M100rom.asm

fdasm: fdasm.o disassembler.o region.o ui.o
	g++ fdasm.o disassembler.o region.o ui.o imgui*.o -o fdasm ${LDFLAGS}

fdasm.o: fdasm.cpp disassembler.h
	g++ -c ${CXXFLAGS} fdasm.cpp -o fdasm.o

disassembler.o: disassembler.cpp disassembler.h
	g++ -c ${CXXFLAGS} disassembler.cpp -o disassembler.o

region.o: region.cpp region.h
	g++ -c ${CXXFLAGS} region.cpp -o region.o

CF2=-O3 --std=c++1z `sdl2-config --cflags` -Iexternal/imgui -Iexternal/imgui/backends 

ui.o: ui.cpp ui.h
	# c++ ${CF2} -c external/imgui/backends/imgui_impl_sdl2.cpp -o imgui_impl_sdl2.o
	# c++ ${CF2} -c external/imgui/backends/imgui_impl_opengl3.cpp -o imgui_impl_opengl3.o
	# c++ ${CF2} -c external/imgui/imgui.cpp -o imgui.o
	# c++ ${CF2} -c external/imgui/imgui_demo.cpp -o imgui_demo.o
	# c++ ${CF2} -c external/imgui/imgui_draw.cpp -o imgui_draw.o
	# c++ ${CF2} -c external/imgui/imgui_tables.cpp -o imgui_tables.o
	# c++ ${CF2} -c external/imgui/imgui_widgets.cpp -o imgui_widgets.o
	g++ ${CF2} -c ${CXXFLAGS} ui.cpp -o ui.o

clean:
	rm -f fdasm fdasm.o disassembler.o region.o ui.o
