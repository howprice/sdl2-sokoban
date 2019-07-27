# TMX

(TMX C Loader)[https://github.com/baylej/tmx/], depends on [zlib](https://www.zlib.net/) and [LibXML2](http://www.xmlsoft.org/).

## Windows

Run [install_tmx.bat](install_tmx.bat) or follow the manual build steps below.

The example is for a 64-bit build. For a 32-bit build replace x64 with x86 unless otherwise stated. 

### Building zlib on Windows

1. Open a *x64 Native Tools Command Prompt for VS 2017*
2. Download and unpack [zlib source code](https://www.zlib.net/):

        cd C:\src
        curl -O https://www.zlib.net/zlib-1.2.11.tar.gz
        tar xf zlib-1.2.11.tar.gz
3. Build:

        cd zlib-1.2.11
        mkdir build
        cd build
        cmake .. -G"Visual Studio 15 2017" -A x64 -DCMAKE_INSTALL_PREFIX="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11"
		    (use -A Win32 for x86 32-bit build)
        msbuild /P:Configuration=Release INSTALL.vcxproj
4. Move libs into x64 folder:

        robocopy C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\bin C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\bin\x64 * /MOV
        robocopy C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib\x64 * /MOV

### Building LibXML2 on Windows

1. Download and unpack [LibXML2 source code](ftp://xmlsoft.org/libxml2/)
 
        cd C:\src
        curl -O ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz
        tar xf libxml2-2.9.9.tar.gz
2. Build

        cd libxml2-2.9.9\win32
        cscript configure.js compiler=msvc prefix=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\libxml2-2.9.9 libdir=$(PREFIX)\lib\x64 sodir=$(PREFIX)\bin\x64 bindir=$(PREFIX)\bin\x64 trio=no ftp=no http=no html=no c14n=no catalog=no docb=no xpath=yes xptr=no xinclude=no iconv=no icu=no iso8859x=no zlib=yes lzma=no debug=no xml_debug=no mem_debug=no run_debug=no schemas=no schematron=no regexps=no modules=no tree=yes reader=yes writer=yes walker=no pattern=no push=yes valid=no sax1=no legacy=no output=yes python=no include=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\include lib=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib\x64
        nmake /F Makefile.msvc
        nmake /f Makefile.msvc install

### Building TMX on Windows

    git clone https://github.com/baylej/tmx/ C:\GitHub\baylej\tmx
    cd C:\GitHub\baylej\tmx
    mkdir build
    cd build
    cmake .. -G"Visual Studio 15 2017" -A x64 -DCMAKE_INSTALL_PREFIX="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\tmx" -DZLIB_INCLUDE_DIR="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\include" -DZLIB_LIBRARY:FILEPATH="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib\x64\zlib.lib" -DLIBXML2_INCLUDE_DIR:PATH="C:\GitHub\howprice\sdl2-sokoban\3rdParty\libxml2-2.9.9\include\libxml2" -DLIBXML2_LIBRARIES:PATH="C:\GitHub\howprice\sdl2-sokoban\3rdParty\libxml2-2.9.9\lib\x64" -DLIBXML2_LIBRARY:FILEPATH=C:\GitHub/howprice\sdl2-sokoban\3rdParty\libxml2-2.9.9\lib\x64\libxml2.lib
        (use -A Win32 for x86 32-bit build)
    msbuild /P:Configuration=Release INSTALL.vcxproj
    robocopy /MOVE C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib\x64 *.lib
    robocopy /MOVE /S /E C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib\cmake C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib\x64\cmake

## Linux

TODO

## Mac OS X

TODO
