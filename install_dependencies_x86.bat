@echo off

IF NOT "%VSCMD_ARG_TGT_ARCH%" == "x86" (
	ECHO Please run in Visual Studio x86 Native Tools Command Prompt
	EXIT /B 1
)

IF NOT EXIST C:\src mkdir C:\src
pushd C:\src

IF NOT EXIST zlib-1.2.11.tar.gz (
	ECHO Downloading zlib
	curl -O https://www.zlib.net/zlib-1.2.11.tar.gz
) 
ECHO Building zlib 
IF EXIST zlib-1.2.11 rmdir /S /Q zlib-1.2.11
tar xf zlib-1.2.11.tar.gz
pushd zlib-1.2.11
mkdir build
pushd build
cmake .. -G"Visual Studio 15 2017" -A Win32 -DCMAKE_INSTALL_PREFIX="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11"
msbuild /P:Configuration=Release INSTALL.vcxproj
popd
rmdir /S /Q build
popd
robocopy C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\bin C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\bin\x86 * /MOV
robocopy C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib C:\GitHub\howprice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib\x86 * /MOV

IF NOT EXIST libxml2-2.9.9.tar.gz (
	ECHO Downloading LibXML2
	curl -O ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz
)
ECHO Building LibXML2
IF EXIST libxml2-2.9.9 rmdir /S /Q libxml2-2.9.9
tar xf libxml2-2.9.9.tar.gz
pushd libxml2-2.9.9
pushd win32
cscript configure.js compiler=msvc prefix=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\libxml2-2.9.9 libdir=$(PREFIX)\lib\x86 sodir=$(PREFIX)\bin\x86 bindir=$(PREFIX)\bin\x86 trio=no ftp=no http=no html=no c14n=no catalog=no docb=no xpath=yes xptr=no xinclude=no iconv=no icu=no iso8859x=no zlib=yes lzma=no debug=no xml_debug=no mem_debug=no run_debug=no schemas=no schematron=no regexps=no modules=no tree=yes reader=yes writer=yes walker=no pattern=no push=yes valid=no sax1=no legacy=no output=yes python=no include=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\include lib=C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\lib\x86
nmake /F Makefile.msvc
nmake /f Makefile.msvc install
popd
popd

IF EXIST tmx rmdir /S /Q tmx
ECHO Cloning TMX
git clone https://github.com/baylej/tmx
pushd tmx
ECHO Building TMX
IF EXIST build rmdir /S /Q build
mkdir build
pushd build
cmake .. -G"Visual Studio 15 2017" -A Win32 -DCMAKE_INSTALL_PREFIX="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\tmx" -DZLIB_INCLUDE_DIR="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11\include" -DZLIB_LIBRARY:FILEPATH="C:\GitHub\HowPrice\sdl2-sokoban\3rdParty\zlib-1.2.11/lib\x86\zlib.lib" -DLIBXML2_INCLUDE_DIR:PATH="C:\GitHub\howprice\sdl2-sokoban\3rdParty\libxml2-2.9.9\include\libxml2" -DLIBXML2_LIBRARIES:PATH="C:\GitHub\howprice\sdl2-sokoban\3rdParty\libxml2-2.9.9\lib\x86" -DLIBXML2_LIBRARY:FILEPATH=C:\GitHub\howprice\sdl2-sokoban\3rdParty\libxml2-2.9.9\lib\x86\libxml2.lib
msbuild /P:Configuration=Release INSTALL.vcxproj
popd
rmdir /S /Q build
robocopy /MOVE C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib\x86 *.lib
robocopy /MOVE /S /E C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib\cmake C:\GitHub\howprice\sdl2-sokoban\3rdParty\tmx\lib\x86\cmake
popd

popd
