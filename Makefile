# Makefile - layer Makefile for OpenCV
#
# Copyright 2017-2019 Wind River Systems, Inc.
#      
# The right to copy, distribute, modify or otherwise make use
# of this software may be licensed only pursuant to the terms
# of an applicable Wind River license agreement.
#
# modification history
# --------------------
# 10jun19,rcw  build with cmake
# 21mar18,d_l  add llvm support
# 05feb18,d_l  re-written
# 13nov17,d_l  create


PRE_BUILD_DIRS = src

# POSTBUILD_USRLIB_DIRS = src

POSTBUILD_RTP_DIRS = src

include $(WIND_KRNL_MK)/rules.layers.mk
