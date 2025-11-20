@echo off
echo Select build type:
echo 1. Full build (delete build folder, reconfigure, rebuild everything)
echo 2. Clean build (clean outputs, do not reconfigure)
echo 3. Incremental build (build changed files only)
@REM echo 4. Partial build (build a selected target)
set /p option=Choose (1-3):

REM Helper: Configure if build folder doesn't exist
set need_config=false
IF NOT EXIST build (
    set need_config=true
)

REM FULL BUILD: delete build folder, reconfigure, build all
if "%option%"=="1" (
    echo Performing FULL build...
    IF EXIST build (
        rmdir /s /q build
    )
    cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_C_COMPILER=C:/MinGW/bin/gcc.exe
    IF ERRORLEVEL 1 (
        echo CMake configuration failed!
        exit /b 1
    )
    cmake --build build
    IF ERRORLEVEL 1 (
        echo Build failed!
        exit /b 1
    )
    echo Running executable...
    build\main_exec.exe
    pause
    exit /b
)

REM CLEAN BUILD: configure if needed, clean/rebuild
if "%option%"=="2" (
    echo Performing CLEAN build...
    IF "%need_config%"=="true" (
        echo Build directory not found, configuring project...
        cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_C_COMPILER=C:/MinGW/bin/gcc.exe
        IF ERRORLEVEL 1 (
            echo CMake configuration failed!
            exit /b 1
        )
    )
    cmake --build build --target clean
    IF ERRORLEVEL 1 (
        echo Clean failed!
        exit /b 1
    )
    cmake --build build
    IF ERRORLEVEL 1 (
        echo Build failed!
        exit /b 1
    )
    echo Running executable...
    build\main_exec.exe
    pause
    exit /b
)

REM INCREMENTAL BUILD: configure if needed, build only changed
if "%option%"=="3" (
    echo Performing INCREMENTAL build...
    IF "%need_config%"=="true" (
        echo Build directory not found, configuring project...
        cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_C_COMPILER=C:/MinGW/bin/gcc.exe
        IF ERRORLEVEL 1 (
            echo CMake configuration failed!
            exit /b 1
        )
    )
    cmake --build build
    IF ERRORLEVEL 1 (
        echo Build failed!
        exit /b 1
    )
    echo Running executable...
    build\main_exec.exe
    pause
    exit /b
)

@REM REM PARTIAL BUILD: configure if needed, then list/validate/build target
@REM if "%option%"=="4" (
@REM     IF "%need_config%"=="true" (
@REM         echo Build directory not found, configuring project...
@REM         cmake -S . -B build -G "MinGW Makefiles" -DCMAKE_C_COMPILER=C:/MinGW/bin/gcc.exe
@REM         IF ERRORLEVEL 1 (
@REM             echo CMake configuration failed!
@REM             exit /b 1
@REM         )
@REM     )

@REM     REM Save all clean targets to 'cleaned_targets.txt'
@REM     > cleaned_targets.txt (
@REM         for /f "delims=:" %%t in ('findstr /R /C:"^[a-zA-Z0-9_-]*:" build\Makefile ^| findstr /V /C:".o:" ^| findstr /V /C:".d:" ^| findstr /V /C:".c:" ^| findstr /V /C:".obj:" ^| findstr /V /C:".a:" ^| findstr /V /C:".h:" ^| findstr /V /C:".exe:" ^| findstr /V /C:".lib:" ^| findstr /V /C:".dll:" ^| findstr /V /C:".so:" ^| findstr /V "=" ^| findstr /V "^#"') do (
@REM             REM Remove trailing/leading whitespace and carriage returns
@REM             for /f %%A in ("%%t") do echo %%~A
@REM         )
@REM     )

@REM     echo Available build targets:
@REM     for /f "delims=" %%t in (cleaned_targets.txt) do (
@REM         echo    %%t
@REM     )

@REM     set valid_target=false
@REM     set /p user_target=Enter the target name for partial build EXACTLY as shown:

@REM     REM Match input directly to cleaned_targets.txt lines (case-insensitive)
@REM     for /f "delims=" %%t in (cleaned_targets.txt) do (
@REM         if /I "%%t"=="%user_target%" set valid_target=true
@REM     )

@REM     if "%valid_target%"=="true" (
@REM         echo Performing PARTIAL build of target: %user_target%...
@REM         cmake --build build --target %user_target%
@REM     ) else (
@REM         echo Invalid target name! Please run the script again and choose a listed target.
@REM     )

@REM     del cleaned_targets.txt
@REM     pause
@REM     exit /b
)

echo Invalid option!
pause
