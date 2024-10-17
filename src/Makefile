# -Wextra -Werror -pedantic 
# CXXFLAGS=-std=c++14 -Wall -O3
CXXFLAGS=-g -std=c++14 -Wall -O0 -I ../external/imgui
LDFLAGS=-std=c++14 -lSDL2 -lSDL2_image -framework OpenGL

# List of object files
OBJS= annotations.o cpuinfo.o disassembler.o explorer.o label.o romfile.o ui.o fdasm.o 

../fdasm: ${OBJS}
	g++ ${OBJS} imgui*.o -o ../fdasm ${LDFLAGS}

test: ../fdasm
	../fdasm M100rom.bin /M100rom.fda

# Rules to build object files
%.o: %.cpp
	g++ -c ${CXXFLAGS} $< -o $@

CF2=-O3 --std=c++1z `sdl2-config --cflags` -I../external/imgui -I../external/imgui/backends 

ui.o: ui.cpp ui.h
	# c++ ${CF2} -c ../external/imgui/backends/imgui_impl_sdl2.cpp -o imgui_impl_sdl2.o
	# c++ ${CF2} -c ../external/imgui/backends/imgui_impl_opengl3.cpp -o imgui_impl_opengl3.o
	# c++ ${CF2} -c ../external/imgui/imgui.cpp -o imgui.o
	# c++ ${CF2} -c ../external/imgui/imgui_demo.cpp -o imgui_demo.o
	# c++ ${CF2} -c ../external/imgui/imgui_draw.cpp -o imgui_draw.o
	# c++ ${CF2} -c ../external/imgui/imgui_tables.cpp -o imgui_tables.o
	# c++ ${CF2} -c ../external/imgui/imgui_widgets.cpp -o imgui_widgets.o
	g++ ${CF2} -c ${CXXFLAGS} ui.cpp -o ui.o

clean:
	rm -f fdasm ${OBJS}
