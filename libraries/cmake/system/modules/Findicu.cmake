cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_LIST_DIR}/api.cmake")

locateSystemLibrary(
  NAME icu
  REQUIRED ${icu_REQUIRED}
  MAIN_HEADER "unicode/utypes.h"
  LIBRARIES "icui18n"
)
