# -Wextra -Werror -pedantic 
# CXXFLAGS=-std=c++14 -Wall -O3
# CXXFLAGS=-g -std=c++14 -Wall -Wextra -Wpedantic -O0 -I ../external/imgui
# CF2=-O3 --std=c++1z `sdl2-config --cflags` -I../external/imgui -I../external/imgui/backends 
CXXFLAGS=-O3 --std=c++1z `sdl2-config --cflags` -I../external/imgui -I../external/imgui/backends  -I. -Imodel -Iui
LDFLAGS=-std=c++14 -lSDL2 -lSDL2_image -framework OpenGL

# List of object files
OBJS= model/annotations.o model/cpuinfo.o model/disassembler.o model/explorer.o model/label.o model/romfile.o ui/ui.o model/xrefs.o ui/panel.o ui/adrsinspector.o ui/byteinspector.o ui/codeinspector.o ui/datainspector.o ui/modal.o fdasm.o model/comment.o

../fdasm: ${OBJS}
	g++ ${OBJS} imgui/imgui*.o -o ../fdasm ${LDFLAGS}

test: ../fdasm
	../fdasm M100rom.bin /M100rom.fda

# Rules to build object files
%.o: %.cpp
	g++ -c ${CXXFLAGS} -MMD -MP $< -o $@


imgui_objs:
	c++ ${CXXFLAGS} -c ../external/imgui/backends/imgui_impl_sdl2.cpp -o imgui/imgui_impl_sdl2.o
	c++ ${CXXFLAGS} -c ../external/imgui/backends/imgui_impl_opengl3.cpp -o imgui/imgui_impl_opengl3.o
	c++ ${CXXFLAGS} -c ../external/imgui/imgui.cpp -o imgui/imgui.o
	c++ ${CXXFLAGS} -c ../external/imgui/imgui_demo.cpp -o imgui/imgui_demo.o
	c++ ${CXXFLAGS} -c ../external/imgui/imgui_draw.cpp -o imgui/imgui_draw.o
	c++ ${CXXFLAGS} -c ../external/imgui/imgui_tables.cpp -o imgui/imgui_tables.o
	c++ ${CXXFLAGS} -c ../external/imgui/imgui_widgets.cpp -o imgui/imgui_widgets.o

clean:
	rm -f fdasm ${OBJS} *.d

# Include the dependency files
-include $(OBJS:.o=.d)
