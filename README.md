# sdl2-sokoban [![Build Status](https://travis-ci.org/howprice/sdl2-sokoban.svg?branch=master)](https://travis-ci.org/howprice/sdl2-sokoban)

Sokoban game written in C++ and SDL2

## Dependencies

This project depends on [SDL2](https://www.libsdl.org), [SDL_image 2.0](https://www.libsdl.org/projects/SDL_image/), [SDL_ttf 2.0](https://www.libsdl.org/projects/SDL_ttf/) and (TMX C Loader)[https://github.com/baylej/tmx/], which depends on [zlib](https://www.zlib.net/) and [LibXML2](http://www.xmlsoft.org/).


### Installing dependencies on Windows

Clone the repository before installing dependencies

    git clone https://github.com/howprice/sdl2-sokoban C:\GitHub\howprice\sdl2-sokoban

The following assumes that the repo has been cloned to C:\GitHub\howprice\sdl2-sokoban. The example is for a 64-bit build. For a 32-bit build replace x64 with x86 unless otherwise stated.

Note: Windows 10 April 2018 Update and onwards have [tar and curl preinstalled](https://devblogs.microsoft.com/commandline/tar-and-curl-come-to-windows/). 

#### Building zlib on Windows

1. Open a *x64 Native Tools Command Prompt for VS 2017*
2. Download and unpack [zlib source code](https://www.zlib.net/):

        cd C:\src
        curl -O https://www.zlib.net/zlib-1.2.11.tar.gz
        tar xf zlib-1.2.11.tar.gz
3. Build:

        cd zlib-1.2.11
        mkdir build
        cd build
        cmake .. -G"Visual Studio 15 2017" -A x64 -DCMAKE_INSTALL_PREFIX="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11"         (use -A Win32 for 32-bit build)
        msbuild /P:Configuration=Release INSTALL.vcxproj
4. Move libs into x64 folder:

        robocopy C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\bin C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\bin\x64 * /MOV
        robocopy C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib\x64 * /MOV

#### Building LibXML2 on Windows

1. Download and unpack [LibXML2 source code](ftp://xmlsoft.org/libxml2/)
 
        cd C:\src
        curl -O ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz
        tar xf libxml2-2.9.9.tar.gz
2. Build

        cd libxml2-2.9.9\win32
        cscript configure.js compiler=msvc prefix=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\libxml2-2.9.9 libdir=$(PREFIX)\lib\x64 sodir=$(PREFIX)\bin\x64 bindir=$(PREFIX)\bin\x64 trio=no ftp=no http=no html=no c14n=no catalog=no docb=no xpath=yes xptr=no xinclude=no iconv=no icu=no iso8859x=no zlib=yes lzma=no debug=no xml_debug=no mem_debug=no run_debug=no schemas=no schematron=no regexps=no modules=no tree=yes reader=yes writer=yes walker=no pattern=no push=yes valid=no sax1=no legacy=no output=yes python=no include=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\include lib=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib\x64
        nmake /F Makefile.msvc
        nmake /f Makefile.msvc install

#### Building TMX on Windows

    git clone https://github.com/baylej/tmx/ C:\GitHub\baylej\tmx
    cd C:\GitHub\baylej\tmx
    mkdir build
    cd build
    cmake .. -G"Visual Studio 15 2017" -A x64 -DCMAKE_INSTALL_PREFIX="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\tmx" -DZLIB_INCLUDE_DIR="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\include" -DZLIB_LIBRARY:FILEPATH="C:/GitHub/HowPrice/sdl2-sokoban/3rdParty/zlib-1.2.11/lib/x64/zlib.lib" -DLIBXML2_INCLUDE_DIR:PATH="C:\GitHub\howprice\sdl2-sokoban\3rdParty\libxml2-2.9.9\include\libxml2" -DLIBXML2_LIBRARIES:PATH="C:\GitHub\howprice\sdl2-sokoban\3rdParty\libxml2-2.9.9\lib\x64" -DLIBXML2_LIBRARY:FILEPATH=C:/GitHub/howprice/sdl2-sokoban/3rdParty/libxml2-2.9.9/lib/x64/libxml2.lib
    msbuild /P:Configuration=Release INSTALL.vcxproj
    robocopy /MOVE /S /E C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\x64
    robocopy /MOVE /S /E C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\x64 C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib\x64

TODO: Figure out how to do those last two lines in one!

#### SDL2

The [SDL2 Development libraries for Visual C++](https://www.libsdl.org/download-2.0.php) are checked in to 3rdparty for convenience. 
TODO: Remove from repo and add steps to install

### Installing dependencies on Linux

TODO

### Installing dependencies on Mac OS X

TODO

## References:
- [TMX Wiki](https://github.com/baylej/tmx/wiki/Build-dependencies-on-Windows)
- https://docs.microsoft.com/en-us/cognitive-toolkit/setup-buildzlib-vs17

## Building and Running

This project uses [GENie](https://github.com/bkaradzic/genie) to generate the build files for the target platform. The GENie executables for Windows, Linux, Mac OS X and Raspberry Pi can be found in the [tools](tools) directory for convenience.

There are three build configurations:
- Debug - no optimisations, symbols, asserts
- Dev - optimisations, symbols, asserts
- Release - optimisations, no symbols, no asserts

### Windows

Download or clone the repository. Run genie_vs2017.bat or genie_vs2019.bat. This will build the Visual Studio Solution and Project files into the 'build' folder. Build and run from within visual studio.

### Linux

[Download dependencies](https://www.libsdl.org/download-2.0.php) and install from source, or install using a package manager. For example, for Ubuntu and Raspberry Pi:

	$ sudo apt-get install libsdl2-dev
	$ sudo apt-get install libsdl2-image-dev
	$ sudo apt-get install libsdl2-ttf-dev

Clone this repo, build the makefiles and build:

	$ git clone https://github.com/howprice/sdl2-sokoban
	$ cd sdl2-sokoban
	$ ./genie_gmake.sh  (or ./genie_raspberrypi.sh)
	$ cd build
	$ make

n.b. You may need to 'chmod +x' genie executable and or .sh shell script files.

`make` with no config specified defaults to the debug config for native architecture (usually 64-bit). Can call `make config=<xxx>` where `xxx` can be `debug`, `dev`, `release`, `debug32`, `dev32`, `release32`, `debug64`, `dev64` or `release64`. Or type `make help` for more info. Make sure you're in the `build` folder.

To run the game

	$ cd data
	$ ../bin/debug/sdl2-sokoban   (or dev or release)

## Mac OS X

[Download dependencies](https://www.libsdl.org/download-2.0.php) and install from source, or install using [Brew](http://brew.sh):

	$ brew install sdl2
	$ brew install sdl2_image
	$ brew install sdl2_ttf
	
Clone this repo, build the makefiles for either gcc (aliased to clang on Mac) or Xcode:

	$ ./genie_gmake.sh   // then build and run as Linux above
	
or

	$ ./genie_xcode10.sh   // then build and run in XCode

## Cleaning the build files

	$ ./genie_clean.sh

## Controls

## Links and thanks

- [Tiled](https://www.mapeditor.org/)
- [baylej/tmx C tmx map loader](https://github.com/baylej/tmx)
- Yuji Adachi for the [ARCADE_N.TTF font](https://www.dafont.com/arcade-ya.font)

## TODO

- Prefix genie.lua defines with WIN_
- Remove all Doxygen style comments and headers
- Get game building on Windows
  - Remove "_access" (search source)
- Remove zlib, libxml2 etc version numbers from genie.lua?
- Remove SDL2 VC dev packages from repo. Add install instructions (curl + tar) and write install_dependencies.bat script. 
- Simpify zlib build instructions? Is it possible to pass INSTALL_BIN_DIR, INSTALL_LIB_DIR etc on command line (see CMakeLists.txt) and remove robocopy step?

Create scripts/build.bat file (see https://github.com/electronicarts/EACopy)


Build https://github.com/baylej/tmx for Linux

- Build this project with cmake?
- Set up Travis-ci
- Add Controls above
- Latest version of Tiled
- Add support for loading standard Sokoban SOK level files https://inventwithpython.com/pygame/chapter9.html http://sokobano.de/wiki/index.php?title=Level_format 
- Figure out relative path problem when loading tileset pngs (I have manually made the paths relative in the .tmx files as a work-around)

## License

See the [LICENSE](LICENSE) file for details.
