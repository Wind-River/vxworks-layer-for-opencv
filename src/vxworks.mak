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

.PHONY: default

include common.mak

# ADDED_LIBS += -lunix -lnet -lHASH -lOPENSSL -lzlib
ADDED_LIBS += -lzlib -lgfxPng

# ADDED_CFLAGS += -isystem${VSB_DIR}/usr/h/published/UTILS

CMAKE_OPT += -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
CMAKE_OPT += -DOPENCV_SKIP_GC_SECTIONS=ON
CMAKE_OPT += -DBUILD_PNG=ON
CMAKE_OPT += -DBUILD_PACKAGE=OFF
CMAKE_OPT += -DBUILD_PERF_TESTS=OFF
CMAKE_OPT += -DBUILD_PROTOBUF=OFF
CMAKE_OPT += -DBUILD_ZLIB=OFF
CMAKE_OPT += -DBUILD_opencv_java=OFF
CMAKE_OPT += -DBUILD_opencv_python2=OFF
CMAKE_OPT += -DBUILD_opencv_python3=OFF
CMAKE_OPT += -DOPENCL_FOUND=OFF
CMAKE_OPT += -DOPENCV_DNN_OPENCL=OFF
CMAKE_OPT += -DWITH_1394=OFF
CMAKE_OPT += -DWITH_ADE=OFF
CMAKE_OPT += -DWITH_ARITH_DEC=OFF
CMAKE_OPT += -DWITH_ARITH_ENC=OFF
CMAKE_OPT += -DWITH_FFMPEG=OFF
CMAKE_OPT += -DWITH_GSTREAMER=OFF
CMAKE_OPT += -DWITH_IMGCODEC_PFM=OFF
CMAKE_OPT += -DWITH_IMGCODEC_PXM=OFF
CMAKE_OPT += -DWITH_IMGCODEC_HDR=OFF
CMAKE_OPT += -DWITH_IMGCODEC_SUNRASTER=OFF
CMAKE_OPT += -DWITH_ITT=OFF
CMAKE_OPT += -DWITH_JASPER=OFF
CMAKE_OPT += -DWITH_JPEG=OFF
CMAKE_OPT += -DWITH_LAPACK=OFF
CMAKE_OPT += -DWITH_OPENCL=OFF
CMAKE_OPT += -DWITH_OPENCLAMDBLAS=OFF
CMAKE_OPT += -DWITH_OPENCLAMDFFT=OFF
CMAKE_OPT += -DWITH_OPENEXR=OFF
CMAKE_OPT += -DWITH_PROTOBUF=OFF
CMAKE_OPT += -DWITH_QUIRC=OFF
CMAKE_OPT += -DWITH_TIFF=OFF
CMAKE_OPT += -DWITH_WEBP=OFF
CMAKE_OPT += -DWITH_EIGEN=OFF
CMAKE_OPT += -DWITH_GTK=OFF
CMAKE_OPT += -DWITH_VTK=OFF 
CMAKE_OPT += -DWITH_V4L=OFF


include defs.packages.mk
include defs.crossbuild.mk

CMAKE_INSTALL_PREFIX = $(VSB_DIR)/usr
# Override MAKE_INSTALL_OPT to avoid setting DESTDIR=$(VSB_DIR)/usr/root
MAKE_INSTALL_OPT = install

include rules.packages.mk

default: $(AUTO_INCLUDE_VSB_CONFIG_QUOTE) $(__AUTO_INCLUDE_LIST_UFILE) | $(TOOL_OPTIONS_FILES_ALL)

$(PKG_NAME).configure : $(CONFIGURE_DEPENDS) $(PKG_NAME).patch
	@$(call echo_action,Configuring,$(PKG_NAME))
	if [ -n "$(VXWORKS_ENV_SH)" ] && \
	   [ -f $(VXWORKS_ENV_SH) ]; then \
		. ./$(VXWORKS_ENV_SH); \
	fi ; \
	$(call pkg_configure,$(PKG_NAME))
	@$(MAKE_STAMP)
#
$(PKG_NAME).build : $(PKG_NAME).configure
	@$(call echo_action,Building,$(PKG_NAME))
	if [ -n "$(VXWORKS_ENV_SH)" ] && \
	   [ -f $(VXWORKS_ENV_SH) ]; then \
		. ./$(VXWORKS_ENV_SH); \
	fi ; \
	$(call pkg_build,$(PKG_NAME))
	@$(MAKE_STAMP)
