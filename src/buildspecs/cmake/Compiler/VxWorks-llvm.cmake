# Copyright 2019 Wind River Systems, Inc.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. Neither the name of the copyright holder nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR 
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

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

