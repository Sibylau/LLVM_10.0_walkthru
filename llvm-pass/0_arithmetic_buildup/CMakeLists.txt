cmake_minimum_required(VERSION 3.13.4)
project(0_arithmetic_buildup VERSION 0)
find_package(LLVM REQUIRED CONFIG)

# message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
# message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# Set your project compile flags.
# set(CMAKE_C_COMPILER "/usr/local/bin/gcc")
# set(CMAKE_CXX_COMPILER "/usr/local/bin/g++")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti -std=c++14")

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

add_executable(test ArithmeticBuildup.cpp)

# add_library(ArithmeticPass MODULE
#    ArithmeticBuildup.cpp)

# Find the libraries that correspond to the LLVM components
# that we wish to use
# llvm_map_components_to_libnames(llvm_libs support core irreader)

# Link against LLVM libraries
# target_link_libraries(simple-tool ${llvm_libs})
