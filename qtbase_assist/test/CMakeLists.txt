cmake_minimum_required (VERSION 3.5)

project (demo)


set (SRC_LIST ${PROJECT_SOURCE_DIR}/test.cpp)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC -DPIC -Wno-deprecated")

include_directories (${PROJECT_SOURCE_DIR}/../../../qtbase_corelib/qtcore/include)
include_directories (${PROJECT_SOURCE_DIR}/../../../qtbase_corelib/qtcore/include/QtCore)

find_library(QTCORE_LIB Qt5Core HINTS ${PROJECT_SOURCE_DIR}/../../../qtbase_corelib/qtcore/lib)

add_executable (main ${SRC_LIST})

target_link_libraries (main ${QTCORE_LIB})

