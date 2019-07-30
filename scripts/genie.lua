solution "sdl2-sokoban"
	location "../build"
	configurations { "Debug", "Dev", "Release" }
	platforms { "native", "x32", "x64" }

	configuration "windows"		
					
		buildoptions { 
			-- Disable compiler warnings. These end up in the Project Settings -> C/C++ -> Command Line -> Additional Options, rather than C/C++ -> Advanced -> Disable Specific Warnings 
			"/wd4127", -- conditional expression is constant
			"/wd4505", -- unreferenced local function has been removed	
			
			-- Treat warnings as errors
			-- TODO: Test gcc/clang equivalent
			--"/we4061", -- enumerator 'identifier' in switch of enum 'enumeration' is not explicitly handled by a case label. i.e. Warn even if there is a default
			"/we4062"  -- enumerator 'identifier' in switch of enum 'enumeration' is not handled
		}
		
	configuration "gcc"	
		buildoptions { 
			"-Wswitch"        -- warn when switch is missing case
			--"-Wswitch-enum" -- warn when switch is missing case, even if there is a default
		}
			
	project "sdl2-sokoban"
		kind "ConsoleApp"
		language "C++"
		location "../build"
		files {
			"../README.md",
			"../scripts/genie.lua",
			"../src/**",
			"../3rdParty/tmx/include/*"
		}
		includedirs {
			"../src",
			"../3rdParty/tmx/include"
		}
		flags { "ExtraWarnings", "FatalWarnings" }
		
		links { 
			"SDL2_image", "SDL2_ttf",  -- not in the string returned by `sdl2-config --links`
			"tmx"
		}

		debugdir "../data"		-- debugger working directory
		
		configuration "windows"
			links {
			      "libxml2",
			      "zlib"
			}
			
		configuration "gcc"
			links {
			      "xml2",
			      "z"
			}
		
		
		configuration "x64"
			targetdir "../bin/x64"

		configuration "not x64"
			targetdir "../bin/x86"

		configuration "Debug"
			--defines { "_DEBUG" } Removed this Windows define because using /MD rather than /MDd
			defines { "DEBUG" }
			flags { "Symbols" }
			targetsubdir "debug"

		configuration "Dev"
			flags { "Optimize", "Symbols" }			
			targetsubdir "dev"
	
		configuration "Release"
			defines { "NDEBUG", "RELEASE" }
			flags { "Optimize" }
			targetsubdir "release"
			
		configuration "windows"
			includedirs {
				"../3rdParty/SDL2/include",
				"../3rdParty/SDL2_image/include",
				"../3rdParty/SDL2_ttf/include"
			}
			flags { "ReleaseRuntime" }  
			links { "SDL2", "SDL2main" }
			defines { "_CRT_SECURE_NO_WARNINGS" }

			postbuildcommands { 
				"copy ..\\3rdParty\\SDL2\\lib\\$(PlatformTarget)\\*.dll ..\\bin\\$(PlatformTarget)\\$(ConfigurationName)",
				"copy ..\\3rdParty\\SDL2_image\\lib\\$(PlatformTarget)\\*.dll ..\\bin\\$(PlatformTarget)\\$(ConfigurationName)",
				"copy ..\\3rdParty\\SDL2_ttf\\lib\\$(PlatformTarget)\\*.dll ..\\bin\\$(PlatformTarget)\\$(ConfigurationName)",
				"copy ..\\3rdParty\\libxml2\\bin\\$(PlatformTarget)\\*.dll ..\\bin\\$(PlatformTarget)\\$(ConfigurationName)",
				"copy ..\\3rdParty\\zlib\\bin\\$(PlatformTarget)\\*.dll ..\\bin\\$(PlatformTarget)\\$(ConfigurationName)",
			}


		configuration { "windows", "release" }
			buildoptions "/wd4390" -- empty controlled statement found; is this the intent? Required for ImGui in release

		configuration { "windows", "not x64" }
			libdirs { 
				"../3rdParty/SDL2/lib/x86",
				"../3rdParty/SDL2_image/lib/x86",
				"../3rdParty/SDL2_ttf/lib/x86",
				"../3rdparty/libxml2/lib/x86",
				"../3rdparty/zlib/lib/x86",
				"../3rdParty/tmx/lib/x86"
			}

		configuration { "windows", "x64" }		
			libdirs { 
				"../3rdParty/SDL2/lib/x64",
				"../3rdParty/SDL2_image/lib/x64",
				"../3rdParty/SDL2_ttf/lib/x64",
				"../3rdParty/libxml2/lib/x64",
				"../3rdparty/zlib/lib/x64",
				"../3rdParty/tmx/lib/x64",
			}

		configuration "gcc"
			buildoptions_cpp { "-std=c++11" }
			buildoptions { "-Wno-missing-field-initializers" }
			
		configuration "linux"
			buildoptions { "-Wno-unused-function" }
			buildoptions { "-Wno-missing-braces" }
			
			-- ImGui with my HP_ASSERT macro gives: error: assuming signed overflow does not occur when assuming that (X - c) > X is always false [-Werror=strict-overflow]
			buildoptions { "-Wno-strict-overflow" }
			
			buildoptions { "`sdl2-config --cflags`" }  -- magic quotes are shell-dependent
			linkoptions { "`sdl2-config --libs`" } -- magic quotes are shell-dependent

			--libdirs { "/opt/vc/lib" } -- really just Raspberry Pi only (VideoCore) 
			links { "EGL", "GLESv2", "GL", "dl" }
			
		configuration { "linux", "release" }
			buildoptions { "-Wno-empty-body" } -- ImGui GCC release error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body] (assert related)

		configuration "macosx"
			buildoptions { "-Wno-unused-function" }
			buildoptions { "-Wno-missing-braces" }

			-- ImGui OSX dependencies from example makefile
			-- OpenGL, Cocoa, IOKit CoreVideo
			linkoptions {
				    "-framework CoreFoundation",
				    "-framework Cocoa"
				    
			}

		configuration { "macosx", "xcode*" }
if os.get() == "macosx" then
			buildoptions { os.outputof("sdl2-config --cflags") } -- magic quotes are no good for Xcode so can't use `sdl2-config --cflags`
			linkoptions { os.outputof("sdl2-config --libs") }
end

		configuration { "macosx", "not xcode*" }
			buildoptions { "`sdl2-config --cflags`" } -- magic quotes are no good for Xcode
			linkoptions { "`sdl2-config --libs`" }

newaction
{
	trigger = "clean",
	shortname = "clean",
	description = "Removes generated files."
}
			
if _ACTION == "clean" then
	os.rmdir("../bin")
	if os.get() == "windows" and os.isdir("../build/.vs") then
		os.outputof("rmdir ..\\build\\.vs /s /q") -- remove the hidden .vs directory
	end
	if os.get() == "macosx" then
		os.outputof("rm -rf build") -- remove the build folder, including hidden .DS_Store file
	end
	os.rmdir("../build") -- this doesn't work unless the hidden .vs has been removed from the folder first folder
end
