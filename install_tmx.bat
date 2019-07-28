REM @echo off

set ZLIB_VERSION=1.2.11
set LIBXML2_VERSION=2.9.9

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
set ZLIB_TARBALL=zlib-%ZLIB_VERSION%.tar.gz
SET ZLIB_URL=https://www.zlib.net/%ZLIB_TARBALL%
IF NOT EXIST %ZLIB_TARBALL% (
	ECHO Downloading %ZLIB_URL%
	curl -O %ZLIB_URL%
	IF NOT EXIST %ZLIB_TARBALL% (
		ECHO Failed to download %ZLIB_URL%
		EXIT /B 1
	)
) 
set ZLIB_DIR=zlib-%ZLIB_VERSION%
IF EXIST %ZLIB_DIR% rmdir /S /Q %ZLIB_DIR%
ECHO Extracting %ZLIB_DIR%
tar xfz %ZLIB_TARBALL%
ECHO Building %ZLIB_DIR%
pushd %ZLIB_DIR%
mkdir build
pushd build
cmake .. -G"Visual Studio 15 2017" -A %CMAKE_PLATFORM_NAME% -DCMAKE_INSTALL_PREFIX="%ROOT%\3rdParty\zlib"
msbuild /P:Configuration=Release INSTALL.vcxproj
popd
rmdir /S /Q build
popd
robocopy %ROOT%\3rdParty\zlib\bin %ROOT%\3rdParty\zlib\bin\%ARCH% * /MOV
robocopy %ROOT%\3rdParty\zlib\lib %ROOT%\3rdParty\zlib\lib\%ARCH% * /MOV


REM LibXML2
REM Download from HTTP, because travis cannot use FTP reliably https://blog.travis-ci.com/2018-07-23-the-tale-of-ftp-at-travis-ci
set LIBXML2_TARBALL=libxml2-%LIBXML2_VERSION%.tar.gz
SET LIBXML2_URL=http://xmlsoft.org/sources/%LIBXML2_TARBALL%
IF NOT EXIST %LIBXML2_TARBALL% (
	ECHO Downloading %LIBXML2_URL%
	curl -O %LIBXML2_URL%
	IF NOT EXIST %LIBXML2_TARBALL% (
		ECHO Failed to download %LIBXML2_URL%
		EXIT /B 1
	)
)
SET LIBXML2_DIR=libxml2-%LIBXML2_VERSION%
IF EXIST %LIBXML2_DIR% rmdir /S /Q %LIBXML2_DIR%
ECHO Extracting %LIBXML2_DIR%
tar xfz %LIBXML2_TARBALL%
ECHO Building %LIBXML2_DIR%
pushd %LIBXML2_DIR%
pushd win32
cscript configure.js compiler=msvc prefix=%ROOT%\3rdParty\libxml2 libdir=$(PREFIX)\lib\%ARCH% sodir=$(PREFIX)\bin\%ARCH% bindir=$(PREFIX)\bin\%ARCH% trio=no ftp=no http=no html=no c14n=no catalog=no docb=no xpath=yes xptr=no xinclude=no iconv=no icu=no iso8859x=no zlib=yes lzma=no debug=no xml_debug=no mem_debug=no run_debug=no schemas=no schematron=no regexps=no modules=no tree=yes reader=yes writer=yes walker=no pattern=no push=yes valid=no sax1=no legacy=no output=yes python=no include=%ROOT%\3rdParty\zlib\include lib=%ROOT%\3rdParty\zlib\lib\%ARCH%
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
cmake .. -G"Visual Studio 15 2017" -A %CMAKE_PLATFORM_NAME% -DCMAKE_INSTALL_PREFIX="%ROOT%\3rdParty\tmx" -DZLIB_INCLUDE_DIR="%ROOT%\3rdParty\zlib\include" -DZLIB_LIBRARY:FILEPATH="%ROOT%\3rdParty\zlib/lib\%ARCH%\zlib.lib" -DLIBXML2_INCLUDE_DIR:PATH="%ROOT%\3rdParty\libxml2\include\libxml2" -DLIBXML2_LIBRARIES:PATH="%ROOT%\3rdParty\libxml2\lib\%ARCH%" -DLIBXML2_LIBRARY:FILEPATH=%ROOT%\3rdParty\libxml2\lib\%ARCH%\libxml2.lib
msbuild /P:Configuration=Release INSTALL.vcxproj
popd
rmdir /S /Q build
robocopy /MOVE %ROOT%\3rdParty\tmx\lib %ROOT%\3rdParty\tmx\lib\%ARCH% *.lib
robocopy /MOVE /S /E %ROOT%\3rdParty\tmx\lib\cmake %ROOT%\3rdParty\tmx\lib\%ARCH%\cmake
popd

popd

EXIT /B 0
