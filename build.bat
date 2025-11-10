@echo off
REM Remove previous build directory if exists
IF EXIST build (
    echo Deleting existing build directory...
    rmdir /s /q build
)

REM Run CMake configuration
echo Configuring project with CMake...
cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_C_COMPILER=C:/MinGW/bin/gcc.exe

REM Check if configuration succeeded
IF ERRORLEVEL 1 (
    echo CMake configuration failed!
    exit /b 1
)

REM Build using CMake
echo Building project...
cmake --build build

REM Check if build succeeded
IF ERRORLEVEL 1 (
    echo Build failed!
    exit /b 1
)

REM Execute the built program
echo Running executable...
build\main_exec.exe

pause
