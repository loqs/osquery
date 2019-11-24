# Copyright (c) 2014-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed in accordance with the terms specified in
# the LICENSE file found in the root directory of this source tree.

locateSystemLibrary(
  NAME libelfin
  REQUIRED ${libelfin_REQUIRED}
  MAIN_HEADER "libelfin/elf/elf++.hh" "libelfin/dwarf/dwarf++.hh"
  LIBRARIES "dwarf++" "elf++"
)