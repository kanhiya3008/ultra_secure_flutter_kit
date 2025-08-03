cmake_minimum_required(VERSION 3.14)
project(ultra_secure_flutter_kit_plugin LANGUAGES CXX)

set(PLUGIN_NAME "ultra_secure_flutter_kit_plugin")

# Configure build options.
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE "Release" CACHE
    STRING "Flutter build mode" FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
    "Debug" "Profile" "Release")
endif()

# Use colored output, which requires CMake 3.16+.
if(POLICY CMP0095)
  cmake_policy(SET CMP0095 NEW)
endif()

# Compilation settings
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Flutter library and tool build rules.
add_subdirectory(${FLUTTER_MANAGED_DIR}/generated_plugin_registrant)

# System-level dependencies.
find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK REQUIRED IMPORTED_TARGET gtk+-3.0)

# Plugin library
add_library(${PLUGIN_NAME} SHARED
  "ultra_secure_flutter_kit_linux.cpp"
  "flutter/generated_plugin_registrant.cc"
  "flutter/generated_plugin_registrant.h"
)

apply_standard_settings(${PLUGIN_NAME})
target_link_libraries(${PLUGIN_NAME} PRIVATE flutter flutter_wrapper_plugin)
target_include_directories(${PLUGIN_NAME} INTERFACE
  "${CMAKE_SOURCE_DIR}/include")
add_dependencies(${PLUGIN_NAME} flutter_assemble)

# Generated plugin build rules
include(flutter/generated_plugins.cmake)

# Installation
install(TARGETS ${PLUGIN_NAME} RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}"
  COMPONENT Runtime) 