@echo off

SET script_path=%~dp0
pushd %script_path%

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x86
call install_tmx.bat

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\VC\Auxiliary\Build\vcvarsall.bat" x64
call install_tmx.bat

popd

EXIT /B 0
