# Copyright (c) 2014-present, Facebook, Inc.
# All rights reserved.
#
# This source code is licensed in accordance with the terms specified in
# the LICENSE file found in the root directory of this source tree.

cmake_minimum_required(VERSION 3.15)

function(locateSystemLibrary)
  cmake_parse_arguments(
    PARSE_ARGV 0
    "ARGS"
    "REQUIRED"
    "NAME;MAIN_HEADER"
    "LIBRARIES;HEADER_PATH_SUFFIX_LIST"
  )

  set(find_path_hints
    "${CMAKE_INSTALL_PREFIX}/include"
    "/usr/local/include"
    "/usr/include"
    "/include"
  )

  set(find_library_hints
    "${CMAKE_INSTALL_PREFIX}/lib64"
    "/usr/local/lib64"
    "/usr/lib64"
    "/lib64"

    "${CMAKE_INSTALL_PREFIX}/lib"
    "/usr/local/lib"
    "/usr/lib"
    "/lib"
  )

  if(ARGS_REQUIRED)
    set(error_type "FATAL_ERROR")
  else()
    set(error_type "WARNING")
  endif()

  if(NOT "${ARGS_HEADER_PATH_SUFFIX_LIST}" STREQUAL "")
    set(optional_path_suffixes_parameter PATH_SUFFIXES ${ARGS_HEADER_PATH_SUFFIX_LIST})
  endif()

  unset(main_header_path CACHE)
  find_path(main_header_path
    NAME "${ARGS_MAIN_HEADER}"
    PATHS ${find_path_hints}
    ${optional_path_suffixes_parameter}
  )

  if("${main_header_path}" STREQUAL "main_header_path-NOTFOUND")
    message("${error_type}" "Failed to import library ${ARGS_NAME}. The following header file was not found: ${ARGS_MAIN_HEADER}")
    return()
  endif()

  foreach(current_library_name ${ARGS_LIBRARIES})
    unset(current_library_path CACHE)
    find_library(current_library_path
      NAME "${current_library_name}"
      PATHS ${find_library_hints}
    )

    if("${current_library_path}" STREQUAL "current_library_path-NOTFOUND")
      message("${error_type}" "Failed to import library ${ARGS_NAME}. The following library was not found: ${current_library_name}")
      return()
    endif()

    set(imported_library_name "${ARGS_NAME}_${current_library_name}")

    add_library("${imported_library_name}" UNKNOWN IMPORTED GLOBAL)
    set_target_properties("${imported_library_name}" PROPERTIES
      IMPORTED_LOCATION "${current_library_path}"
    )

    list(APPEND imported_library_list "${imported_library_name}")

    unset(current_library_path CACHE)
    unset(current_library_path)
  endforeach()

  add_library("${ARGS_NAME}" INTERFACE)
  target_link_libraries("${ARGS_NAME}" INTERFACE ${imported_library_list})
  target_include_directories("${ARGS_NAME}" INTERFACE "${main_header_path}")

  set("${ARGS_NAME}_FOUND" true PARENT_SCOPE)
endfunction()
