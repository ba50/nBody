# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/bartek/openCL/adventures_in_opencl/nBody

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/bartek/openCL/adventures_in_opencl/nBody/buile

# Include any dependencies generated for this target.
include CMakeFiles/nBody.x.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/nBody.x.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/nBody.x.dir/flags.make

CMakeFiles/nBody.x.dir/main.cpp.o: CMakeFiles/nBody.x.dir/flags.make
CMakeFiles/nBody.x.dir/main.cpp.o: ../main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bartek/openCL/adventures_in_opencl/nBody/buile/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/nBody.x.dir/main.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/nBody.x.dir/main.cpp.o -c /home/bartek/openCL/adventures_in_opencl/nBody/main.cpp

CMakeFiles/nBody.x.dir/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/nBody.x.dir/main.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/bartek/openCL/adventures_in_opencl/nBody/main.cpp > CMakeFiles/nBody.x.dir/main.cpp.i

CMakeFiles/nBody.x.dir/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/nBody.x.dir/main.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/bartek/openCL/adventures_in_opencl/nBody/main.cpp -o CMakeFiles/nBody.x.dir/main.cpp.s

CMakeFiles/nBody.x.dir/main.cpp.o.requires:

.PHONY : CMakeFiles/nBody.x.dir/main.cpp.o.requires

CMakeFiles/nBody.x.dir/main.cpp.o.provides: CMakeFiles/nBody.x.dir/main.cpp.o.requires
	$(MAKE) -f CMakeFiles/nBody.x.dir/build.make CMakeFiles/nBody.x.dir/main.cpp.o.provides.build
.PHONY : CMakeFiles/nBody.x.dir/main.cpp.o.provides

CMakeFiles/nBody.x.dir/main.cpp.o.provides.build: CMakeFiles/nBody.x.dir/main.cpp.o


# Object files for target nBody.x
nBody_x_OBJECTS = \
"CMakeFiles/nBody.x.dir/main.cpp.o"

# External object files for target nBody.x
nBody_x_EXTERNAL_OBJECTS =

nBody.x: CMakeFiles/nBody.x.dir/main.cpp.o
nBody.x: CMakeFiles/nBody.x.dir/build.make
nBody.x: libpart2.a
nBody.x: /usr/lib64/libglut.so
nBody.x: /usr/lib64/libXmu.so
nBody.x: /usr/lib64/libXi.so
nBody.x: /usr/lib64/libGLU.so
nBody.x: /usr/lib64/libGL.so
nBody.x: /usr/lib64/libGLEW.so
nBody.x: /usr/lib64/libOpenCL.so
nBody.x: CMakeFiles/nBody.x.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/bartek/openCL/adventures_in_opencl/nBody/buile/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable nBody.x"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/nBody.x.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/nBody.x.dir/build: nBody.x

.PHONY : CMakeFiles/nBody.x.dir/build

CMakeFiles/nBody.x.dir/requires: CMakeFiles/nBody.x.dir/main.cpp.o.requires

.PHONY : CMakeFiles/nBody.x.dir/requires

CMakeFiles/nBody.x.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/nBody.x.dir/cmake_clean.cmake
.PHONY : CMakeFiles/nBody.x.dir/clean

CMakeFiles/nBody.x.dir/depend:
	cd /home/bartek/openCL/adventures_in_opencl/nBody/buile && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/bartek/openCL/adventures_in_opencl/nBody /home/bartek/openCL/adventures_in_opencl/nBody /home/bartek/openCL/adventures_in_opencl/nBody/buile /home/bartek/openCL/adventures_in_opencl/nBody/buile /home/bartek/openCL/adventures_in_opencl/nBody/buile/CMakeFiles/nBody.x.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/nBody.x.dir/depend
