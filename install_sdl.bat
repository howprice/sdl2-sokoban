@echo off

IF NOT EXIST C:\tmp mkdir C:\tmp
pushd C:\tmp


REM SDL
IF NOT EXIST SDL2-devel-2.0.10-VC.zip (
	ECHO Downloading SDL2
	curl -O https://www.libsdl.org/release/SDL2-devel-2.0.10-VC.zip
)
tar xfz SDL2-devel-2.0.10-VC.zip
robocopy /MOVE /S /E SDL2-2.0.10 C:\GitHub\howprice\sdl2-sokoban\3rdParty\SDL2-2.0.10


REM SDL2_image
IF NOT EXIST SDL2_image-devel-2.0.5-VC.zip (
	ECHO Downloading SDL2_image
	curl -O https://www.libsdl.org/projects/SDL_image/release/SDL2_image-devel-2.0.5-VC.zip
)
tar xfz SDL2_image-devel-2.0.5-VC.zip
robocopy /MOVE /S /E SDL2_image-2.0.5 C:\GitHub\howprice\sdl2-sokoban\3rdParty\SDL2_image-2.0.5


REM SDL2_ttf

IF NOT EXIST SDL2_ttf-devel-2.0.15-VC.zip (
	ECHO Downloading SDL2_ttf
	curl -O https://www.libsdl.org/projects/SDL_ttf/release/SDL2_ttf-devel-2.0.15-VC.zip
)
tar xfz SDL2_ttf-devel-2.0.15-VC.zip
robocopy /MOVE /S /E SDL2_ttf-2.0.15 C:\GitHub\howprice\sdl2-sokoban\3rdParty\SDL2_ttf-2.0.15


popd
