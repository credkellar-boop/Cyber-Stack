cmake_minimum_required(VERSION 3.18)

# Configure CUDA target architectures explicitly
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
    set(CMAKE_CUDA_ARCHITECTURES 80 86 89) # Target Ampere and Ada Lovelace hardware generations
endif()

# Define the library compiled from CUDA source files
add_library(cuda_acceleration STATIC matrix_mul.cu)

set_target_properties(cuda_acceleration PROPERTIES
    CUDA_SEPARABLE_COMPILATION ON
    POSITION_INDEPENDENT_CODE ON
)

target_include_directories(cuda_acceleration PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
