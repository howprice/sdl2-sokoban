# sdl2-sokoban [![Build Status](https://travis-ci.org/howprice/sdl2-sokoban.svg?branch=master)](https://travis-ci.org/howprice/sdl2-sokoban)

Sokoban game written in C++ and SDL2

## Dependencies

This project depends on [SDL2](https://www.libsdl.org), [SDL_image 2.0](https://www.libsdl.org/projects/SDL_image/) and [SDL_ttf 2.0](https://www.libsdl.org/projects/SDL_ttf/)

### Building zlib on Windows 10

The following example is for a 64-bit build. For a 32-bit build replace x64 with x86.

1. Open a *x64 Native Tools Command Prompt for VS 2017*
2. Download [zlib source code](https://www.zlib.net/)

        curl -O https://www.zlib.net/zlib-1.2.11.tar.gz
3. Unpack to folder

        cd C:\src
        tar xf zlib-1.2.11.tar.gz
4. Build

        mkdir build
        cd build
        cmake .. -G"Visual Studio 15 2017" -A x64'    (use -A Win32 for 32-bit build)
        msbuild /P:Configuration=Release zlib.vcxproj'
5. Copy headers and DLL into sokoban project

        xcopy ..\*.h C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\include /s /i /f'
        xcopy Release\zlib.dll C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\bin\x86\* /i /f'

### Building LibXML2 on Windows 10

 1. Download [LibXML2](ftp://xmlsoft.org/libxml2/) e.g. 'libxml2-2.9.9.tar.gz'
 2. Extract archive to folder e.g. 'C:\Code\libxml2-2.9.9' (use [7zip](http://7-zip.org/))
 3. Open a Visual Studio command prompt
    - For 32-bit Start -> Visual Studio 2017 -> x86 Native Tools Command Prompt for VS 2017
	- For 64-bit Start -> Visual Studio 2017 -> x64 Native Tools Command Prompt for VS 2017
 4. 'cd C:\Code\libxml2-2.9.9\win32''
 5. 'cscript configure.js trio=no ftp=no http=no html=no c14n=no catalog=no docb=no xpath=yes xptr=no xinclude=no iconv=no icu=no iso8859x=no zlib=yes lzma=no debug=no xml_debug=no mem_debug=no run_debug=no schemas=no schematron=no regexps=no modules=no tree=yes reader=yes writer=yes walker=no pattern=no push=yes valid=no sax1=no legacy=no output=yes python=no include=C:\Code\zlib-1.2.11 lib=c:\Code\zlib-1.2.11\build\Release'
 6. 'nmake /F Makefile.msvc''
 7. 'nmake /f Makefile.msvc install'   (this creates "package" i.e. the 'include', 'libs', and 'bin' folders)
 8. Copy 'includes' folder e.g. 'xcopy include C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\libxml2-2.9.9\include /s /i /f'
 9. Copy 'libs' folder e.g. 'xcopy lib C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\libxml2-2.9.9\lib\x86 /s /i /f'
 10. Copy DLL from 'bin' folder e.g. 'xcopy bin\libxml2.dll C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\libxml2-2.9.9\bin\x86\* /i /f'

References:
- [TMX Wiki](https://github.com/baylej/tmx/wiki/Build-dependencies-on-Windows)
- https://docs.microsoft.com/en-us/cognitive-toolkit/setup-buildzlib-vs17

## Building and Running

This project uses [GENie](https://github.com/bkaradzic/genie) to generate the build files for the target platform. The GENie executables for Windows, Linux, Mac OS X and Raspberry Pi can be found in the [tools](tools) directory for convenience.

There are three build configurations:
- Debug - no optimisations, symbols, asserts
- Dev - optimisations, symbols, asserts
- Release - optimisations, no symbols, no asserts

### Windows

The [SDL2 Development libraries for Visual C++](https://www.libsdl.org/download-2.0.php) are checked in to 3rdparty for convenience. 

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

- Build TMX as separate library (Revert tmx src to vanilla, removing warning fixes too)
- Fix Windows x64 build
- Add Zlib and libxml2 to README
- Prefix genie.lua defines with WIN_
- Remove all Doxygen style comments and headers
- Get game building on Windows
  - Remove "_access" (search source)

- Set up Travis-ci
- Add Controls above
- Latest version of Tiled
- Add support for loading standard Sokoban SOK level files https://inventwithpython.com/pygame/chapter9.html http://sokobano.de/wiki/index.php?title=Level_format 
- Figure out relative path problem when loading tileset pngs (I have manually made the paths relative in the .tmx files as a work-around)

## License

See the [LICENSE](LICENSE) file for details.
