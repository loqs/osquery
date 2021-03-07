cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_LIST_DIR}/api.cmake")

locateSystemLibrary(
  NAME expat
  REQUIRED ${expat_REQUIRED}
  MAIN_HEADER "expat.h"
  LIBRARIES "expat"
)
