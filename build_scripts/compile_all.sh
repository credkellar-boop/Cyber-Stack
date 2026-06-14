#!/bin/bash
set -euo pipefail

# 1. Build Rust Orchestrator
echo "==> Building Rust Orchestrator..."
# Move to the directory first. This makes the local folder the "root"
cd core_systems/rust_orchestrator
# Build without --manifest-path, which forces Cargo to look 
# only for a Cargo.toml in the current directory (or its parents).
# Since there is no root Cargo.toml here, it will not trigger workspace logic.
cargo build --release
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
