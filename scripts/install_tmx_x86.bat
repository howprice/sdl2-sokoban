@echo off

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86

SET script_path=%~dp0
pushd %script_path%
call install_tmx.bat
popd
