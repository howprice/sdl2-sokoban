
-- Windows lib folders
-- TODO: Prefix with WIN_
SDL2 = "SDL2-2.0.10"
SDL2_IMAGE = "SDL2_image-2.0.5"
SDL2_TTF = "SDL2_ttf-2.0.15"
LIBXML = "libxml2-2.9.9"
ZLIB = "zlib-1.2.11"
--ICONV = "iconv-1.9.2.win32"

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
			"../3rdParty/tmx/*.h",
			"../3rdParty/tmx/*.c",
		}
		includedirs {
			"../src",
			"../3rdParty/tmx/"
		}
		flags { "ExtraWarnings", "FatalWarnings" }
		links { 
			"SDL2_image", "SDL2_ttf",  -- not in the string returned by `sdl2-config --links`
			"libxml2", 
			--"zlib" 
		}
		defines { "WANT_ZLIB" }
		debugdir "../data"		-- debugger working directory
		
		configuration "Debug"
			--defines { "_DEBUG" } Removed this Windows define because using /MD rather than /MDd
			defines { "DEBUG" }
			flags { "Symbols" }
			targetdir "../bin/debug"

		configuration "Dev"
			flags { "Optimize", "Symbols" }			
			targetdir "../bin/dev"
	
		configuration "Release"
			defines { "NDEBUG", "RELEASE" }
			flags { "Optimize" }
			targetdir "../bin/release"
			
		configuration "windows"
			includedirs {
				"../3rdParty/" .. SDL2 .. "/include",
				"../3rdParty/" .. SDL2_IMAGE .. "/include",
				"../3rdParty/" .. SDL2_TTF .. "/include",
				"../3rdparty/" .. LIBXML .. "/include/libxml2",
				"../3rdparty/" .. ZLIB .. "/include",
				--"../3rdparty/" .. ICONV .. "/include"
			}
			flags { "ReleaseRuntime" }  
			links { "SDL2", "SDL2main" }
			defines { "_CRT_SECURE_NO_WARNINGS" }

		configuration { "windows", "release" }
			buildoptions "/wd4390" -- empty controlled statement found; is this the intent? Required for ImGui in release

		configuration { "windows", "not x64" }
			libdirs { 
				"../3rdParty/" .. SDL2 .. "/lib/x86",
				"../3rdParty/" .. SDL2_IMAGE .. "/lib/x86",
				"../3rdParty/" .. SDL2_TTF .. "/lib/x86",
				"../3rdparty/" .. LIBXML .. "/lib/x86",
				--"../3rdparty/" .. ZLIB .. "/lib",
				--"../3rdparty/" .. ICONV .. "/lib"
			}
			postbuildcommands { 
				"copy ..\\3rdParty\\" .. SDL2 .. "\\lib\\x86\\*.dll ..\\bin\\$(ConfigurationName)",
				"copy ..\\3rdParty\\" .. SDL2_IMAGE .. "\\lib\\x86\\*.dll ..\\bin\\$(ConfigurationName)",
				"copy ..\\3rdParty\\" .. SDL2_TTF .. "\\lib\\x86\\*.dll ..\\bin\\$(ConfigurationName)",
				"copy ..\\3rdParty\\" .. LIBXML .. "\\bin\\x86\\*.dll ..\\bin\\$(ConfigurationName)",
				"copy ..\\3rdParty\\" .. ZLIB .. "\\bin\\x86\\*.dll ..\\bin\\$(ConfigurationName)",
				--"copy ..\\3rdparty\\" .. ICONV .. "\\bin\\*.dll ..\\bin\\$(ConfigurationName)"
			}

		configuration { "windows", "x64" }		
			libdirs { 
				"../3rdParty/" .. SDL2 .. "/lib/x64",
				"../3rdParty/" .. SDL2_IMAGE .. "/lib/x64",
				"../3rdParty/" .. SDL2_TTF .. "/lib/x64"
			}
			postbuildcommands { 
				"copy ..\\3rdParty\\" .. SDL2 .. "\\lib\\x64\\*.dll ..\\bin\\$(ConfigurationName)",
				"copy ..\\3rdParty\\" .. SDL2_IMAGE .. "\\lib\\x64\\*.dll ..\\bin\\$(ConfigurationName)",
				"copy ..\\3rdParty\\" .. SDL2_TTF .. "\\lib\\x64\\*.dll ..\\bin\\$(ConfigurationName)"
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
	if os.get() == "windows" then
		os.outputof("rmdir ..\\build\\.vs /s /q") -- remove the hidden .vs directory
	end
	if os.get() == "macosx" then
		os.outputof("rm -rf build") -- remove the build folder, including hidden .DS_Store file
	end
	os.rmdir("../build")			-- this doesn't work because the directory contains .vs folder
end
