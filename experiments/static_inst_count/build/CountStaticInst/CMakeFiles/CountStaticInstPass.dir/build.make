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
CMAKE_SOURCE_DIR = /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build

# Include any dependencies generated for this target.
include CountStaticInst/CMakeFiles/CountStaticInstPass.dir/depend.make

# Include the progress variables for this target.
include CountStaticInst/CMakeFiles/CountStaticInstPass.dir/progress.make

# Include the compile flags for this target's objects.
include CountStaticInst/CMakeFiles/CountStaticInstPass.dir/flags.make

CountStaticInst/CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.o: CountStaticInst/CMakeFiles/CountStaticInstPass.dir/flags.make
CountStaticInst/CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.o: ../CountStaticInst/CountStaticInstPass.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CountStaticInst/CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.o"
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CountStaticInst && /usr/local/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.o -c /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/CountStaticInst/CountStaticInstPass.cpp

CountStaticInst/CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.i"
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CountStaticInst && /usr/local/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/CountStaticInst/CountStaticInstPass.cpp > CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.i

CountStaticInst/CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.s"
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CountStaticInst && /usr/local/bin/g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/CountStaticInst/CountStaticInstPass.cpp -o CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.s

# Object files for target CountStaticInstPass
CountStaticInstPass_OBJECTS = \
"CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.o"

# External object files for target CountStaticInstPass
CountStaticInstPass_EXTERNAL_OBJECTS =

CountStaticInst/libCountStaticInstPass.so: CountStaticInst/CMakeFiles/CountStaticInstPass.dir/CountStaticInstPass.cpp.o
CountStaticInst/libCountStaticInstPass.so: CountStaticInst/CMakeFiles/CountStaticInstPass.dir/build.make
CountStaticInst/libCountStaticInstPass.so: CountStaticInst/CMakeFiles/CountStaticInstPass.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module libCountStaticInstPass.so"
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CountStaticInst && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/CountStaticInstPass.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CountStaticInst/CMakeFiles/CountStaticInstPass.dir/build: CountStaticInst/libCountStaticInstPass.so

.PHONY : CountStaticInst/CMakeFiles/CountStaticInstPass.dir/build

CountStaticInst/CMakeFiles/CountStaticInstPass.dir/clean:
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CountStaticInst && $(CMAKE_COMMAND) -P CMakeFiles/CountStaticInstPass.dir/cmake_clean.cmake
.PHONY : CountStaticInst/CMakeFiles/CountStaticInstPass.dir/clean

CountStaticInst/CMakeFiles/CountStaticInstPass.dir/depend:
	cd /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/CountStaticInst /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CountStaticInst /work/shared/users/phd/jl3952/tutorials/LLVM/experiments/static_inst_count/build/CountStaticInst/CMakeFiles/CountStaticInstPass.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CountStaticInst/CMakeFiles/CountStaticInstPass.dir/depend

