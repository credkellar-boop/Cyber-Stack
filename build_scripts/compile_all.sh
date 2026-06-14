#!/bin/bash
set -euo pipefail

# Capture the absolute path to the root of the repo
ROOT_DIR=$(pwd)

echo "==> Building Rust Orchestrator..."
# Use the absolute path explicitly
cargo build --manifest-path "$ROOT_DIR/core_systems/rust_orchestrator/Cargo.toml" --release

# 2. Compile C++/CUDA via CMake
echo "==> Building C++/CUDA Core Targets..."
rm -rf "$ROOT_DIR/core_systems/build"
mkdir -p "$ROOT_DIR/core_systems/build"
cd "$ROOT_DIR/core_systems/build"
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
cd "$ROOT_DIR"

# 3. Compile Zig Utilities
echo "==> Building Zig Utilities..."
# Target the build file using the absolute path
zig build --build-file "$ROOT_DIR/core_systems/zig_utils/build.zig"

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
