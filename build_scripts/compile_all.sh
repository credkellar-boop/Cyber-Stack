#!/bin/bash
set -euo pipefail

echo "==> Building Rust Orchestrator..."

# 1. Enter the specific directory. 
# Cargo will look for a Cargo.toml in this directory.
# This prevents it from trying to resolve the root workspace.
cd core_systems/rust_orchestrator

# 2. Build the package explicitly.
# By naming the package, we tell Cargo to focus only on this target.
cargo build --release --package cyber_stack_orchestrator

# 3. Return to the root directory for other builds
cd ../..

# 4. Compile C++/CUDA via CMake
echo "==> Building C++/CUDA Core Targets..."
rm -rf core_systems/build
mkdir -p core_systems/build
cd core_systems/build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
cd ../..

# 5. Compile Zig Utilities
echo "==> Building Zig Utilities..."
zig build --build-file core_systems/zig_utils/build.zig

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
