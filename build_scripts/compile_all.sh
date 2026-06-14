#!/bin/bash
set -euo pipefail

echo "==> Building Rust Orchestrator..."
# Use --manifest-path to point directly to the file
cargo build --manifest-path core_systems/rust_orchestrator/Cargo.toml --release

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
# Explicitly use the zig build file path if needed
zig build --build-file core_systems/zig_utils/build.zig

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
