# VxWorks.cmake -- Platform Definitions for VxWorks
#
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

set(CMAKE_FIND_ROOT_PATH $ENV{PRJ_WS}/install)

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
