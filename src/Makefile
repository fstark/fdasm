# Define the object directory
OBJDIR = ../obj

# Define the compiler and flags
CXX = g++
CXXFLAGS = -Wextra -Werror -pedantic 
CXXFLAGS += -std=c++14 -Wall -O3 `sdl2-config --cflags` -I external/imgui -Iexternal/imgui/backends -I. -Iui -Imodel
LDFLAGS = -std=c++14 -lSDL2 -lSDL2_image -framework OpenGL

# List of source directories
SRCDIRS = ui model

IMGUISRC = external/imgui/backends/imgui_impl_sdl2.cpp external/imgui/backends/imgui_impl_opengl3.cpp external/imgui/imgui.cpp external/imgui/imgui_demo.cpp external/imgui/imgui_draw.cpp external/imgui/imgui_tables.cpp external/imgui/imgui_widgets.cpp

# List of source files
SRCS = $(wildcard $(addsuffix /*.cpp, $(SRCDIRS))) $(IMGUISRC) fdasm.cpp

# List of object files
OBJS = $(patsubst %.cpp, $(OBJDIR)/%.o, $(SRCS))

# Target executable
TARGET = ../fdasm

# Default target
all: $(TARGET)

# Rule to link the target executable
$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $(TARGET) $(LDFLAGS)

# Rule to compile source files into object files
$(OBJDIR)/%.o: %.cpp | $(OBJDIR)
	$(CXX) $(CXXFLAGS) -c -MMD -MP $< -o $@ 

# Create the object directory if it doesn't exist
$(OBJDIR):
	mkdir -p $(OBJDIR)
	mkdir -p $(OBJDIR)/ui
	mkdir -p $(OBJDIR)/model
	mkdir -p $(OBJDIR)/external/imgui/backends

# Include the dependency files
-include $(OBJS:.o=.d)

# Clean rule to remove object files and the target executable
clean:
	rm -f $(TARGET) $(OBJS)
	rm -rf $(OBJDIR)

# Phony targets
.PHONY: all clean
