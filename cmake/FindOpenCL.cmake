# Minimal FindOpenCL.cmake for Android cross-compilation.
#
# The stock CMake FindOpenCL module does try_compile CL_VERSION checks with
# the NDK clang toolchain, which fail in CI and reset OpenCL_LIBRARY/INCLUDE_DIR
# even when both are passed via -D. This module only validates the paths
# provided on the command line (-DOpenCL_INCLUDE_DIR / -DOpenCL_LIBRARY).
# ponytail: bypasses version probing entirely; the loader is built from pinned
# Khronos sources in the workflow, so version detection adds no value here.
if(NOT DEFINED OpenCL_INCLUDE_DIR)
    set(OpenCL_INCLUDE_DIR "" CACHE PATH "Path to OpenCL headers directory")
endif()
if(NOT DEFINED OpenCL_LIBRARY)
    set(OpenCL_LIBRARY "" CACHE FILEPATH "Path to OpenCL loader library")
endif()

set(OpenCL_VERSION_STRING "3.0")
set(OpenCL_VERSION_MAJOR 3)
set(OpenCL_VERSION_MINOR 0)
set(OpenCL_INCLUDE_DIRS "${OpenCL_INCLUDE_DIR}")
set(OpenCL_INCLUDE_DIR  "${OpenCL_INCLUDE_DIR}")
set(OpenCL_LIBRARIES    "${OpenCL_LIBRARY}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenCL
    REQUIRED_VARS OpenCL_INCLUDE_DIR OpenCL_LIBRARY
    VERSION_VAR OpenCL_VERSION_STRING)

mark_as_advanced(OpenCL_INCLUDE_DIR OpenCL_LIBRARY)