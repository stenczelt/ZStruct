project(zstruct CXX)

file(GLOB ${PROJECT_NAME}_sources "*.cpp")
message(STATUS "Sources for project ${PROJECT_NAME}: ${${PROJECT_NAME}_sources}")

# this is the "object library" target: compiles the sources only once
add_executable(${PROJECT_NAME} ${${PROJECT_NAME}_sources})

# link MKL
target_compile_options(${PROJECT_NAME} PUBLIC $<TARGET_PROPERTY:MKL::MKL,INTERFACE_COMPILE_OPTIONS>)
target_include_directories(${PROJECT_NAME} PUBLIC $<TARGET_PROPERTY:MKL::MKL,INTERFACE_INCLUDE_DIRECTORIES>)
target_link_libraries(${PROJECT_NAME} PUBLIC $<LINK_ONLY:MKL::MKL>)

# standard: where to put the targets
install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION ${target_bin_dir})
