#!/bin/bash
set -euo pipefail

echo "==> Building Rust Orchestrator in isolation..."
# Enter the directory, then build without looking for a workspace
cd core_systems/rust_orchestrator
# Use CARGO_MANIFEST_DIR to force the build context to this folder
CARGO_MANIFEST_DIR=$(pwd) cargo build --release
cd ../..

# 2. Compile C++/CUDA via CMake
echo "==> Building C++/CUDA Core Targets..."
rm -rf core_systems/build
mkdir -p core_systems/build
cd core_systems/build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
cd ../..

# 3. Compile Zig Utilities
echo "==> Building Zig Utilities..."
zig build

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
