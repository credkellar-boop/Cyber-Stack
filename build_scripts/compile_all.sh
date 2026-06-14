#!/bin/bash
set -euo pipefail

echo "==> Compiling Core Cyber-Stack Workspace"

# 1. Compile Rust Modules
echo "==> Building Rust Orchestrator..."
cargo build --release --workspace

# 2. Compile C++/CUDA via CMake
echo "==> Building C++/CUDA Core Targets..."
# Remove old build folder to ensure a clean state
rm -rf core_systems/build
mkdir -p core_systems/build
cd core_systems/build

# Run cmake and catch errors
cmake -DCMAKE_BUILD_TYPE=Release .. || { echo "CMake failed"; exit 1; }
make -j$(nproc) || { echo "Make failed"; exit 1; }
cd ../..

# 3. Compile Zig Utilities
echo "==> Building Zig Utilities..."
zig build

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
