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
include CMakeFiles/part2.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/part2.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/part2.dir/flags.make

CMakeFiles/part2.dir/cll.cpp.o: CMakeFiles/part2.dir/flags.make
CMakeFiles/part2.dir/cll.cpp.o: ../cll.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bartek/openCL/adventures_in_opencl/nBody/buile/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/part2.dir/cll.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/part2.dir/cll.cpp.o -c /home/bartek/openCL/adventures_in_opencl/nBody/cll.cpp

CMakeFiles/part2.dir/cll.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/part2.dir/cll.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/bartek/openCL/adventures_in_opencl/nBody/cll.cpp > CMakeFiles/part2.dir/cll.cpp.i

CMakeFiles/part2.dir/cll.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/part2.dir/cll.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/bartek/openCL/adventures_in_opencl/nBody/cll.cpp -o CMakeFiles/part2.dir/cll.cpp.s

CMakeFiles/part2.dir/cll.cpp.o.requires:

.PHONY : CMakeFiles/part2.dir/cll.cpp.o.requires

CMakeFiles/part2.dir/cll.cpp.o.provides: CMakeFiles/part2.dir/cll.cpp.o.requires
	$(MAKE) -f CMakeFiles/part2.dir/build.make CMakeFiles/part2.dir/cll.cpp.o.provides.build
.PHONY : CMakeFiles/part2.dir/cll.cpp.o.provides

CMakeFiles/part2.dir/cll.cpp.o.provides.build: CMakeFiles/part2.dir/cll.cpp.o


CMakeFiles/part2.dir/part2.cpp.o: CMakeFiles/part2.dir/flags.make
CMakeFiles/part2.dir/part2.cpp.o: ../part2.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bartek/openCL/adventures_in_opencl/nBody/buile/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/part2.dir/part2.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/part2.dir/part2.cpp.o -c /home/bartek/openCL/adventures_in_opencl/nBody/part2.cpp

CMakeFiles/part2.dir/part2.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/part2.dir/part2.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/bartek/openCL/adventures_in_opencl/nBody/part2.cpp > CMakeFiles/part2.dir/part2.cpp.i

CMakeFiles/part2.dir/part2.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/part2.dir/part2.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/bartek/openCL/adventures_in_opencl/nBody/part2.cpp -o CMakeFiles/part2.dir/part2.cpp.s

CMakeFiles/part2.dir/part2.cpp.o.requires:

.PHONY : CMakeFiles/part2.dir/part2.cpp.o.requires

CMakeFiles/part2.dir/part2.cpp.o.provides: CMakeFiles/part2.dir/part2.cpp.o.requires
	$(MAKE) -f CMakeFiles/part2.dir/build.make CMakeFiles/part2.dir/part2.cpp.o.provides.build
.PHONY : CMakeFiles/part2.dir/part2.cpp.o.provides

CMakeFiles/part2.dir/part2.cpp.o.provides.build: CMakeFiles/part2.dir/part2.cpp.o


CMakeFiles/part2.dir/util.cpp.o: CMakeFiles/part2.dir/flags.make
CMakeFiles/part2.dir/util.cpp.o: ../util.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/bartek/openCL/adventures_in_opencl/nBody/buile/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/part2.dir/util.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/part2.dir/util.cpp.o -c /home/bartek/openCL/adventures_in_opencl/nBody/util.cpp

CMakeFiles/part2.dir/util.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/part2.dir/util.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/bartek/openCL/adventures_in_opencl/nBody/util.cpp > CMakeFiles/part2.dir/util.cpp.i

CMakeFiles/part2.dir/util.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/part2.dir/util.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/bartek/openCL/adventures_in_opencl/nBody/util.cpp -o CMakeFiles/part2.dir/util.cpp.s

CMakeFiles/part2.dir/util.cpp.o.requires:

.PHONY : CMakeFiles/part2.dir/util.cpp.o.requires

CMakeFiles/part2.dir/util.cpp.o.provides: CMakeFiles/part2.dir/util.cpp.o.requires
	$(MAKE) -f CMakeFiles/part2.dir/build.make CMakeFiles/part2.dir/util.cpp.o.provides.build
.PHONY : CMakeFiles/part2.dir/util.cpp.o.provides

CMakeFiles/part2.dir/util.cpp.o.provides.build: CMakeFiles/part2.dir/util.cpp.o


# Object files for target part2
part2_OBJECTS = \
"CMakeFiles/part2.dir/cll.cpp.o" \
"CMakeFiles/part2.dir/part2.cpp.o" \
"CMakeFiles/part2.dir/util.cpp.o"

# External object files for target part2
part2_EXTERNAL_OBJECTS =

libpart2.a: CMakeFiles/part2.dir/cll.cpp.o
libpart2.a: CMakeFiles/part2.dir/part2.cpp.o
libpart2.a: CMakeFiles/part2.dir/util.cpp.o
libpart2.a: CMakeFiles/part2.dir/build.make
libpart2.a: CMakeFiles/part2.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/bartek/openCL/adventures_in_opencl/nBody/buile/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX static library libpart2.a"
	$(CMAKE_COMMAND) -P CMakeFiles/part2.dir/cmake_clean_target.cmake
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/part2.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/part2.dir/build: libpart2.a

.PHONY : CMakeFiles/part2.dir/build

CMakeFiles/part2.dir/requires: CMakeFiles/part2.dir/cll.cpp.o.requires
CMakeFiles/part2.dir/requires: CMakeFiles/part2.dir/part2.cpp.o.requires
CMakeFiles/part2.dir/requires: CMakeFiles/part2.dir/util.cpp.o.requires

.PHONY : CMakeFiles/part2.dir/requires

CMakeFiles/part2.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/part2.dir/cmake_clean.cmake
.PHONY : CMakeFiles/part2.dir/clean

CMakeFiles/part2.dir/depend:
	cd /home/bartek/openCL/adventures_in_opencl/nBody/buile && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/bartek/openCL/adventures_in_opencl/nBody /home/bartek/openCL/adventures_in_opencl/nBody /home/bartek/openCL/adventures_in_opencl/nBody/buile /home/bartek/openCL/adventures_in_opencl/nBody/buile /home/bartek/openCL/adventures_in_opencl/nBody/buile/CMakeFiles/part2.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/part2.dir/depend

