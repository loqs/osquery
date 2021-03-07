cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_LIST_DIR}/api.cmake")

locateSystemLibrary(
  NAME libcap
  REQUIRED ${cap_REQUIRED}
  MAIN_HEADER "sys/capability.h"
  LIBRARIES "cap"
)
