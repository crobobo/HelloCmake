BUILD_DIRECTORY=cmake-build-unix

# makefile
echo Unix Makefiles
if [ ! -d $BUILD_DIRECTORY ]; then
    cmake -G "CodeBlocks - Unix Makefiles" -B $BUILD_DIRECTORY -S .
fi

# make
pushd $BUILD_DIRECTORY
make

# run
echo -e '\n'
./demo.exe
popd
read -n1 -p "Press any key to continue..."