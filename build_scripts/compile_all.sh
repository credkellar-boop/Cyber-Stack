#!/bin/bash
set -euo pipefail

echo "==> Compiling Core Cyber-Stack Workspace"

# 1. Compile Rust Modules
echo "==> Building Rust Orchestrator..."
# Explicitly build the workspace from the root
cargo build --release -p cyber_stack_orchestrator

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
