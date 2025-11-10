# Specify the minimum required CMake version
cmake_minimum_required(VERSION 3.15)

# Declare the project name and language
project(AUTOSAR_BUILD_SYSTEM C)

# Set the C language standard to C11 and make it required
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Set the output directory for executables, static and shared libraries
# All build outputs will go into the 'build' folder under the project root
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)

# Add each subdirectory representing an AUTOSAR layer/module
# These will look for CMakeLists.txt files inside each listed subdirectory
add_subdirectory(asw)
add_subdirectory(bsw)
add_subdirectory(mcal)
add_subdirectory(cdd)

# Create the main executable from main.c and main.h in the project root
add_executable(main_exec main.c main.h)

# Link the static libraries created in each AUTOSAR layer to the main executable
target_link_libraries(main_exec asw_dummy bsw_dummy mcal_dummy cdd_dummy)

# Make header files from each layer available for inclusion in main_exec
# This allows #include "asw_dummy.h", etc. from main.c
target_include_directories(main_exec
    PRIVATE
        ${PROJECT_SOURCE_DIR}/asw
        ${PROJECT_SOURCE_DIR}/bsw
        ${PROJECT_SOURCE_DIR}/mcal
        ${PROJECT_SOURCE_DIR}/cdd
)
