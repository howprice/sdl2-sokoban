@echo off

set ROOT=%cd%

IF "%VSCMD_ARG_TGT_ARCH%" == "" (
	ECHO Please run in Visual Studio x86 or x64 Native Tools Command Prompt
	EXIT /B 1
)

IF "%VSCMD_ARG_TGT_ARCH%" == "x86" (
	SET CMAKE_PLATFORM_NAME="Win32"
	SET ARCH=%VSCMD_ARG_TGT_ARCH%
)

IF "%VSCMD_ARG_TGT_ARCH%" == "x64" (
	SET CMAKE_PLATFORM_NAME="x64"
	SET ARCH=%VSCMD_ARG_TGT_ARCH%
)

IF NOT EXIST tmp mkdir tmp
pushd tmp


REM zlib
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
cmake .. -G"Visual Studio 15 2017" -A %CMAKE_PLATFORM_NAME% -DCMAKE_INSTALL_PREFIX="%ROOT%\3rdParty\zlib-1.2.11"
msbuild /P:Configuration=Release INSTALL.vcxproj
popd
rmdir /S /Q build
popd
robocopy %ROOT%\3rdParty\zlib-1.2.11\bin %ROOT%\3rdParty\zlib-1.2.11\bin\%ARCH% * /MOV
robocopy %ROOT%\3rdParty\zlib-1.2.11\lib %ROOT%\3rdParty\zlib-1.2.11\lib\%ARCH% * /MOV


REM LibXML2
IF NOT EXIST libxml2-2.9.9.tar.gz (
	ECHO Downloading LibXML2
	curl -O ftp://xmlsoft.org/libxml2/libxml2-2.9.9.tar.gz
)
ECHO Building LibXML2
IF EXIST libxml2-2.9.9 rmdir /S /Q libxml2-2.9.9
tar xf libxml2-2.9.9.tar.gz
pushd libxml2-2.9.9
pushd win32
cscript configure.js compiler=msvc prefix=%ROOT%\3rdParty\libxml2-2.9.9 libdir=$(PREFIX)\lib\%ARCH% sodir=$(PREFIX)\bin\%ARCH% bindir=$(PREFIX)\bin\%ARCH% trio=no ftp=no http=no html=no c14n=no catalog=no docb=no xpath=yes xptr=no xinclude=no iconv=no icu=no iso8859x=no zlib=yes lzma=no debug=no xml_debug=no mem_debug=no run_debug=no schemas=no schematron=no regexps=no modules=no tree=yes reader=yes writer=yes walker=no pattern=no push=yes valid=no sax1=no legacy=no output=yes python=no include=%ROOT%\3rdParty\zlib-1.2.11\include lib=%ROOT%\3rdParty\zlib-1.2.11\lib\%ARCH%
nmake /F Makefile.msvc
nmake /f Makefile.msvc install
popd
popd


REM TMX
IF EXIST tmx rmdir /S /Q tmx
ECHO Cloning TMX
git clone https://github.com/baylej/tmx
pushd tmx
IF EXIST build rmdir /S /Q build
mkdir build
pushd build
cmake .. -G"Visual Studio 15 2017" -A %CMAKE_PLATFORM_NAME% -DCMAKE_INSTALL_PREFIX="%ROOT%\3rdParty\tmx" -DZLIB_INCLUDE_DIR="%ROOT%\3rdParty\zlib-1.2.11\include" -DZLIB_LIBRARY:FILEPATH="%ROOT%\3rdParty\zlib-1.2.11/lib\%ARCH%\zlib.lib" -DLIBXML2_INCLUDE_DIR:PATH="%ROOT%\3rdParty\libxml2-2.9.9\include\libxml2" -DLIBXML2_LIBRARIES:PATH="%ROOT%\3rdParty\libxml2-2.9.9\lib\%ARCH%" -DLIBXML2_LIBRARY:FILEPATH=%ROOT%\3rdParty\libxml2-2.9.9\lib\%ARCH%\libxml2.lib
msbuild /P:Configuration=Release INSTALL.vcxproj
popd
rmdir /S /Q build
robocopy /MOVE %ROOT%\3rdParty\tmx\lib %ROOT%\3rdParty\tmx\lib\%ARCH% *.lib
robocopy /MOVE /S /E %ROOT%\3rdParty\tmx\lib\cmake %ROOT%\3rdParty\tmx\lib\%ARCH%\cmake
popd

popd
