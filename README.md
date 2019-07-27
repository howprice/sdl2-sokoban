# sdl2-sokoban [![Build Status](https://travis-ci.org/howprice/sdl2-sokoban.svg?branch=master)](https://travis-ci.org/howprice/sdl2-sokoban)

Sokoban game written in C++ and SDL2

## Dependencies

This project depends on [SDL2](https://www.libsdl.org), [SDL_image 2.0](https://www.libsdl.org/projects/SDL_image/), [SDL_ttf 2.0](https://www.libsdl.org/projects/SDL_ttf/) and [TMX C Loader](https://github.com/baylej/tmx/), which depends on [zlib](https://www.zlib.net/) and [LibXML2](http://www.xmlsoft.org/).


### Installing dependencies on Windows

It is assumed that [tar and curl are available](https://devblogs.microsoft.com/commandline/tar-and-curl-come-to-windows/). 

Clone the repository before installing dependencies, for example:

    git clone https://github.com/howprice/sdl2-sokoban C:\GitHub\howprice\sdl2-sokoban

#### TMX 
Install TMX and its dependencies by running [install_tmx.bat](install_tmx.bat) from a *Visual Studio Native Tools Command Prompt* or see [TMX.md](TMX.md) for manual installation instructions.

#### SDL2

Run [install_sdl.bat](install_sdl.bat) or download and extract the Windows VC development libraries for [SDL2](https://www.libsdl.org/download-2.0.php), [SDL_image 2.0](https://www.libsdl.org/projects/SDL_image/) and [SDL_ttf 2.0](https://www.libsdl.org/projects/SDL_ttf/) into the [3rdParty] folder.

### Installing dependencies on Linux

    sudo apt install libxml2-dev
    sudo apt install cmake
    git clone https://github.com/baylej/tmx
    cd tmx
    mkdir build
    cmake ..
    make
    sudo make install   
    
    

### Installing dependencies on Mac OS X

TODO

## Building and Running

This project uses [GENie](https://github.com/bkaradzic/genie) to generate the build files for the target platform. The GENie executables for Windows, Linux, Mac OS X and Raspberry Pi can be found in the [tools](tools) directory for convenience.

There are three build configurations:
- Debug - no optimisations, symbols, asserts
- Dev - optimisations, symbols, asserts
- Release - optimisations, no symbols, no asserts

### Windows

Run genie_vs2017.bat or genie_vs2019.bat to generate the Visual Studio Solution and Project files into the 'build' folder. Build and run from within Visual Studio.

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
- [TMX Wiki](https://github.com/baylej/tmx/wiki/Build-dependencies-on-Windows)
- https://docs.microsoft.com/en-us/cognitive-toolkit/setup-buildzlib-vs17


## TODO
- Store lib version numbers in variables in install_sdl.bat and install_tmx.bat
- Simpify zlib build instructions? Is it possible to pass INSTALL_BIN_DIR, INSTALL_LIB_DIR etc on command line (see CMakeLists.txt) and remove robocopy step?
- Create scripts/build.bat file (see https://github.com/electronicarts/EACopy)

- Latest version of Tiled
- Mac OS X build
- Build this project with cmake?
- Set up Travis-ci (have to make repo public first)
- Add Controls above
- Add support for loading standard Sokoban SOK level files https://inventwithpython.com/pygame/chapter9.html http://sokobano.de/wiki/index.php?title=Level_format 
- Figure out relative path problem when loading tileset pngs (I have manually made the paths relative in the .tmx files as a work-around)

## License

See the [LICENSE](LICENSE) file for details.
