# Copyright (c) 2014-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed in accordance with the terms specified in
# the LICENSE file found in the root directory of this source tree.

cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_LIST_DIR}/api.cmake")

locateSystemLibrary(
  NAME libxml2
  REQUIRED ${libxml2_REQUIRED}
  MAIN_HEADER "libxml/xpath.h"
  LIBRARIES "xml2"
  HEADER_PATH_SUFFIX_LIST "libxml2"
)
