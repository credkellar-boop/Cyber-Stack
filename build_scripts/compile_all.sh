#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo "⚡ Compiling Core Cyber-Stack Workspace"
echo "=================================================="

# 1. Compile Rust Modules
echo "-> Building Rust Orchestrator..."
cargo build --release --workspace

# 2. Compile C/C++/CUDA via CMake
echo "-> Building C/C++/CUDA Core Targets..."
mkdir -p core_systems/build
cd core_systems/build
cmake -DCMAKE_BUILD_TYPE=Release ../..
make -j$(nproc)
cd ../..

# 3. Compile Zig Utilities
echo "-> Building Zig Utilities..."
zig build

echo "=================================================="
echo "✅ All Cyber-Stack Subsystems Built Successfully!"
echo "=================================================="
