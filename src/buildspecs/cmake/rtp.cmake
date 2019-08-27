# CMake Toolchain file for RTPs - rtp.mcmake
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

# Must be used from a Wind River environment, i.e. WIND_HOME and
# related environment variables must be set for the build to succeed.
# This file is designed to reside in (VSB_DIR)/cmake
#
# Usage:
# WIND_HOME/wrenv.linux -p <product>
# . ./vxworks_env.sh && cmake -DCMAKE_TOOLCHAIN_FILE=${VSB_DIR}/buildspecs/cmake/rtp.cmake
# make
#
# modification history
# --------------------
# 03aug18,akh  rewritten
# 18oct16,mob  written

# The syntax of this file has been validated to work with cmake-3.10
# - cmake-3.3.0 or later is required for CROSSCOMPILING_EMULATOR to work
cmake_minimum_required(VERSION 2.8.7)

set(CMAKE_SYSTEM_NAME VxWorks)
set(CMAKE_SYSTEM_VERSION 7)
set(CMAKE_CROSSCOMPILING ON)

# add CPPFLAGS here, otherwise cmake does not catch them
set(CMAKE_CXX_FLAGS_INIT "$ENV{CPPFLAGS}")
set(CMAKE_C_FLAGS_INIT "$ENV{CPPFLAGS}")

# set(CMAKE_MODULE_PATH $ENV{VSB_DIR}/buildspecs/cmake)
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR} $ENV{VSB_DIR}/buildspecs/cmake)

