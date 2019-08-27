# VxWorks.cmake -- Platform Definitions for VxWorks
#
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
#
#
# This file is auto-included by cmake, when CMAKE_SYSTEM = VxWorks
# It is included "late" so allows overriding improper defaults
# from the cmake auto-discovery process where appropriate.
#
# modification history
# --------------------
# 03aug18,akh added Platform/GNU
# 16Nov17,ryan Override CMAKE_ASM_COMPILE_OBJECT for ASM support.
# 18oct16,mob  written

set(VXWORKS TRUE)
set(UNIX 1)

SET(CMAKE_EXECUTABLE_SUFFIX ".vxe")

#include(Platform/GNU)

set(CMAKE_SKIP_BUILD_RPATH TRUE)

set(CMAKE_SYSROOT $ENV{VSB_DIR})

set(CMAKE_INCLUDE_PATH
        /usr/root/include
        /usr/h/published/UTILS
        /usr/h/public)

set(CMAKE_LIBRARY_PATH
        /usr/root/lib
        /usr/lib/common)

# Workaround for FindOpenSSL.cmake not knowing VxWorks library names,
# and even failing when the CRYPTO library is not there.
# TODO The proper openssl library name should be contributed to cmake.
find_library(OPENSSL_SSL_LIBRARY OPENSSL)
find_library(OPENSSL_CRYPTO_LIBRARY OPENSSL)
mark_as_advanced(OPENSSL_SSL_LIBRARY OPENSSL_CRYPTO_LIBRARY)

include(Compiler/VxWorks-$ENV{TOOL})
