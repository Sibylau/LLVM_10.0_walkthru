# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.18

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Disable VCS-based implicit rules.
% : %,v


# Disable VCS-based implicit rules.
% : RCS/%


# Disable VCS-based implicit rules.
% : RCS/%,v


# Disable VCS-based implicit rules.
% : SCCS/s.%


# Disable VCS-based implicit rules.
% : s.%


.SUFFIXES: .hpux_make_needs_suffix_list


# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /work/shared/users/phd/jl3952/installs/cmake-3.18.0-Linux-x86_64/bin/cmake

# The command to remove a file.
RM = /work/shared/users/phd/jl3952/installs/cmake-3.18.0-Linux-x86_64/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build

# Include any dependencies generated for this target.
include loop_tracing/CMakeFiles/MyPass.dir/depend.make

# Include the progress variables for this target.
include loop_tracing/CMakeFiles/MyPass.dir/progress.make

# Include the compile flags for this target's objects.
include loop_tracing/CMakeFiles/MyPass.dir/flags.make

loop_tracing/CMakeFiles/MyPass.dir/loop_tracing.cpp.o: loop_tracing/CMakeFiles/MyPass.dir/flags.make
loop_tracing/CMakeFiles/MyPass.dir/loop_tracing.cpp.o: ../loop_tracing/loop_tracing.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object loop_tracing/CMakeFiles/MyPass.dir/loop_tracing.cpp.o"
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/loop_tracing && /usr/local/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/MyPass.dir/loop_tracing.cpp.o -c /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/loop_tracing/loop_tracing.cpp

loop_tracing/CMakeFiles/MyPass.dir/loop_tracing.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/MyPass.dir/loop_tracing.cpp.i"
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/loop_tracing && /usr/local/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/loop_tracing/loop_tracing.cpp > CMakeFiles/MyPass.dir/loop_tracing.cpp.i

loop_tracing/CMakeFiles/MyPass.dir/loop_tracing.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/MyPass.dir/loop_tracing.cpp.s"
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/loop_tracing && /usr/local/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/loop_tracing/loop_tracing.cpp -o CMakeFiles/MyPass.dir/loop_tracing.cpp.s

# Object files for target MyPass
MyPass_OBJECTS = \
"CMakeFiles/MyPass.dir/loop_tracing.cpp.o"

# External object files for target MyPass
MyPass_EXTERNAL_OBJECTS =

loop_tracing/libMyPass.so: loop_tracing/CMakeFiles/MyPass.dir/loop_tracing.cpp.o
loop_tracing/libMyPass.so: loop_tracing/CMakeFiles/MyPass.dir/build.make
loop_tracing/libMyPass.so: loop_tracing/CMakeFiles/MyPass.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module libMyPass.so"
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/loop_tracing && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/MyPass.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
loop_tracing/CMakeFiles/MyPass.dir/build: loop_tracing/libMyPass.so

.PHONY : loop_tracing/CMakeFiles/MyPass.dir/build

loop_tracing/CMakeFiles/MyPass.dir/clean:
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/loop_tracing && $(CMAKE_COMMAND) -P CMakeFiles/MyPass.dir/cmake_clean.cmake
.PHONY : loop_tracing/CMakeFiles/MyPass.dir/clean

loop_tracing/CMakeFiles/MyPass.dir/depend:
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/loop_tracing /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/loop_tracing /work/shared/users/phd/jl3952/tutorials/LLVM/llvm-pass/llvm-tracing/build/loop_tracing/CMakeFiles/MyPass.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : loop_tracing/CMakeFiles/MyPass.dir/depend

