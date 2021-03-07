cmake_minimum_required(VERSION 3.15)
include("${CMAKE_CURRENT_LIST_DIR}/api.cmake")

locateSystemLibrary(
  NAME dbus
  REQUIRED ${dbus_REQUIRED}
  MAIN_HEADER "dbus/dbus.h"
  LIBRARIES "dbus-1"
  HEADER_PATH_SUFFIX_LIST "dbus-1.0"
)
include_directories("/usr/lib/dbus-1.0/include") #TODO add support for this to the API
