cmake_minimum_required(VERSION 3.23)
project(ZStruct CXX)

message("Using ${CMAKE_CXX_COMPILER_ID} compilers")

# target directories
set(target_bin_dir ${PROJECT_BINARY_DIR}/bin)

# OpenMP
find_package(OpenMP REQUIRED)

# Lapack
find_package(LAPACK REQUIRED)
link_libraries(${LAPACK_LIBRARIES})

include_directories(include)

# sources
file(GLOB ${PROJECT_NAME}_sources "src/*.cpp")
message(STATUS "Sources for project ${PROJECT_NAME}: ${${PROJECT_NAME}_sources}")

# "object library" target: compiles the sources only once
add_executable(${PROJECT_NAME} ${${PROJECT_NAME}_sources})
target_link_libraries(${PROJECT_NAME} PRIVATE "${OpenMP_CXX_FLAGS}")
target_compile_options(${PROJECT_NAME} PRIVATE "${OpenMP_CXX_FLAGS}")

# put results on the right place
install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION ${target_bin_dir})