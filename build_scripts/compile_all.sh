#!/bin/bash
set -euo pipefail

# 1. Build Rust Orchestrator in an isolated subshell
echo "==> Building Rust Orchestrator..."
(
  cd core_systems/rust_orchestrator
  # Clear existing lock files that might be causing conflicts
  rm -f Cargo.lock
  # Build specifically within this directory
  cargo build --release
)

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
zig build --build-file core_systems/zig_utils/build.zig

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
