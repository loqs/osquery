# Copyright (c) 2020-present, Anatol Pomazau.
# All rights reserved.
#
# This source code is licensed in accordance with the terms specified in
# the LICENSE file found in the root directory of this source tree.

cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_LIST_DIR}/api.cmake")

locateSystemLibrary(
  NAME alpm
  REQUIRED ${alpm_REQUIRED}
  MAIN_HEADER "alpm.h"
  LIBRARIES "alpm"
)

target_link_libraries(alpm INTERFACE
)

