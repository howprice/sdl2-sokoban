@echo off

SET script_path=%~dp0
pushd %script_path%

REM cd up into repo root
cd ..

SET SDL2_VERSION=2.0.10
SET SDL2_IMAGE_VERSION=2.0.5
SET SDL2_TTF_VERSION=2.0.15

IF NOT EXIST tmp mkdir tmp
pushd tmp


REM SDL2
SET SDL2_ZIP=SDL2-devel-%SDL2_VERSION%-VC.zip
IF NOT EXIST %SDL2_ZIP% (
	ECHO Downloading %SDL2_ZIP%
	curl -O https://www.libsdl.org/release/%SDL2_ZIP%
)
tar xfz %SDL2_ZIP%
IF %ERRORLEVEL% NEQ 0 unzip %SDL2_ZIP%
IF %ERRORLEVEL% NEQ 0 EXIT /B 0
robocopy /MOVE /S /E SDL2-%SDL2_VERSION% ..\3rdParty\SDL2


REM SDL2_image
SET SDL2_IMAGE_ZIP=SDL2_image-devel-%SDL2_IMAGE_VERSION%-VC.zip
IF NOT EXIST %SDL2_IMAGE_ZIP% (
	ECHO Downloading %SDL2_IMAGE_ZIP%
	curl -O https://www.libsdl.org/projects/SDL_image/release/%SDL2_IMAGE_ZIP%
)
tar xfz %SDL2_IMAGE_ZIP%
IF %ERRORLEVEL% NEQ 0 unzip %SDL2_IMAGE_ZIP%
IF %ERRORLEVEL% NEQ 0 EXIT /B 0
robocopy /MOVE /S /E SDL2_image-%SDL2_IMAGE_VERSION% ..\3rdParty\SDL2_image


REM SDL2_ttf
SET SDL2_TTF_ZIP=SDL2_ttf-devel-%SDL2_TTF_VERSION%-VC.zip
IF NOT EXIST %SDL2_TTF_ZIP% (
	ECHO Downloading %SDL2_TTF_ZIP%
	curl -O https://www.libsdl.org/projects/SDL_ttf/release/%SDL2_TTF_ZIP%
)
tar xfz %SDL2_TTF_ZIP%
IF %ERRORLEVEL% NEQ 0 unzip %SDL2_TTF_ZIP%
IF %ERRORLEVEL% NEQ 0 EXIT /B 0
robocopy /MOVE /S /E SDL2_ttf-%SDL2_TTF_VERSION% ..\3rdParty\SDL2_ttf

REM back to repo root
popd

REM back to original directory
popd
