project(ZStruct CXX)
cmake_minimum_required(VERSION 3.23)

# Use C++11
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS} -lstdc++ -stdlib=libc++")

# we need MKL & OpenMP
find_package(MKL CONFIG REQUIRED)
message(STATUS "${MKL_IMPORTED_TARGETS}")

# target directories
set(target_bin_dir ${PROJECT_BINARY_DIR}/bin)

# -----------------------------------------------------------------------------
# Subdirectories
include_directories(include)
add_subdirectory(src)