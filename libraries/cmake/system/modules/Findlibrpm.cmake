# Copyright (c) 2014-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed in accordance with the terms specified in
# the LICENSE file found in the root directory of this source tree.

include("${CMAKE_SOURCE_DIR}/libraries/cmake/source/modules/Findlibrpm.cmake")

target_compile_definitions(thirdparty_librpm PRIVATE
  HAVE_RSA_SET0_KEY
  HAVE_DSA_SET0_KEY
  HAVE_DSA_SET0_PQG
  HAVE_DSA_SIG_SET0
  HAVE_BN2BINPAD
)
