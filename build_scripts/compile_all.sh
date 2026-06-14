#!/bin/bash
set -euo pipefail

echo "==> Building Rust Orchestrator in absolute isolation..."

# Enter the target directory
cd core_systems/rust_orchestrator

# 1. Clear any cached artifacts that might contain bad paths
rm -f Cargo.lock

# 2. Build without searching for a workspace
# By calling 'cargo' from inside the directory and explicitly NOT
# using the --workspace flag, we force it to act on this directory alone.
cargo build --release

# Return to root for the other builds
cd ../..

# 3. Compile C++/CUDA via CMake
echo "==> Building C++/CUDA Core Targets..."
rm -rf core_systems/build
mkdir -p core_systems/build
cd core_systems/build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
cd ../..

# 4. Compile Zig Utilities
echo "==> Building Zig Utilities..."
zig build

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
