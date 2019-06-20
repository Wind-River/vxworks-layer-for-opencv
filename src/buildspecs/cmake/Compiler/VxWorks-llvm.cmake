# Copyright (c) 2019, Wind River Systems, Inc.
#
# MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the ""Software""), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# why -m elf_i386 flag is defined here
set(CMAKE_LINKER "$ENV{LD}")
set(CMAKE_AR "$ENV{AR}")

# setup ldpentium linker, cmake uses compiler as a linker by default, see next line
# set(CMAKE_CXX_LINK_EXECUTABLE "<CMAKE_CXX_COMPILER>  <FLAGS> <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
# set(CMAKE_CXX_CREATE_SHARED_LIBRARY "<CMAKE_CXX_COMPILER> <CMAKE_SHARED_LIBRARY_CXX_FLAGS> <LANGUAGE_COMPILE_FLAGS> <LINK_FLAGS> <CMAKE_SHARED_LIBRARY_CREATE_CXX_FLAGS> <SONAME_FLAG><TARGET_SONAME> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")

# get rid of --start-group --end-group in LIBS
string(REGEX REPLACE "--start-group(.*)--end-group" "\\1" LIBS "$ENV{LIBS}")

# remove dl and syscall in list of LIBS for shared libraries
string(REGEX REPLACE "-ldl" "" SHLIBS "${LIBS}")
string(REGEX REPLACE "-lsyscall" "" SHLIBS "${SHLIBS}")

foreach(lang C CXX ASM)
    string(REPLACE " " ";" CMAKE_${lang}_COMPILE_OPTIONS_PIC $ENV{CCSHARED})
    set(CMAKE_SHARED_LIBRARY_SONAME_${lang}_FLAG "-soname=")
    set(CMAKE_${lang}_CREATE_SHARED_LIBRARY
	    "${CMAKE_LINKER} $ENV{LINKFORSHARED} $ENV{LDFLAGS_SO} $ENV{LDFLAGS_SHARED} -lc_internal <LINK_FLAGS> <SONAME_FLAG><TARGET_SONAME> -o <TARGET> <OBJECTS> --as-needed ${SHLIBS}")

    set(CMAKE_${lang}_LINK_EXECUTABLE
        "${CMAKE_LINKER} $ENV{CRT0_OBJ} <LINK_FLAGS> $ENV{LDFLAGS_DYNAMIC} -dum <OBJECTS> -o <TARGET> --start-group --as-needed ${LIBS} <LINK_LIBRARIES> --end-group")
endforeach()

