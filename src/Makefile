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

.PHONY: all

include common.mak

PKG_EXTRA_SRC = common.mak mk/defs.packages.mk mk/defs.crossbuild.mk mk/rules.packages.mk

CMAKE_BUILDSPECS_PATH = buildspecs/cmake

#ifdef _WRS_CONFIG_UUID
#KERNEL_PUBLIC_H_DIRS += uuid/h
#BUILD_DIRS += uuid/src
#ifdef _WRS_CONFIG_RTP
#USER_PUBLIC_H_DIRS += uuid/h
#BUILD_USER_DIRS += uuid/src
#endif
#endif

default : install_cmake_toolchain_files

install_cmake_toolchain_files :
	@if [ "$$BUILDSTAGE" = "PREBUILD" ]; then \
		echo "Installing CMake toolchain files into VSB"; \
		mkdir -p $(VSB_DIR)/$(CMAKE_BUILDSPECS_PATH)/Platform; \
		mkdir -p  $(VSB_DIR)/$(CMAKE_BUILDSPECS_PATH)/Compiler; \
		cp ./$(CMAKE_BUILDSPECS_PATH)/*.cmake $(VSB_DIR)/$(CMAKE_BUILDSPECS_PATH); \
		cp ./$(CMAKE_BUILDSPECS_PATH)/Platform/*.cmake $(VSB_DIR)/$(CMAKE_BUILDSPECS_PATH)/Platform; \
		cp ./$(CMAKE_BUILDSPECS_PATH)/Compiler/*.cmake $(VSB_DIR)/$(CMAKE_BUILDSPECS_PATH)/Compiler; \
	fi

include mk/defs.packages.mk
include mk/defs.crossbuild.mk
include mk/rules.packages.mk
