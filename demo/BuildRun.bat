@ECHO OFF
CD /D %~dp0
SET BUILD_DIRECTORY=cmake-build-mingw

REM makefile
echo MinGW Makefiles
IF NOT EXIST %BUILD_DIRECTORY% (
    cmake -G "CodeBlocks - MinGW Makefiles" -B %BUILD_DIRECTORY% -S .
)

REM make
PUSHD %BUILD_DIRECTORY%
mingw32-make

REM run
ECHO .
.\demo.exe
POPD
pause