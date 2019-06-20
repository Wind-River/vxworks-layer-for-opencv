# CMake Toolchain file for RTPs - rtp.mcmake
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

