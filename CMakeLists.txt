cmake_minimum_required(VERSION 3.18)
project(CyberStackModules LANGUAGES C CXX CUDA)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CUDA_STANDARD 17)

# Ensure architecture-specific optimization flags
add_compile_options(-O3 -march=native -Wall -Wextra)

# Subdirectory execution targets
add_subdirectory(core_systems/cuda_acceleration)
add_subdirectory(low_level_perf/dpdk_supported)
