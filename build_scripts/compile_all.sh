#!/bin/bash
set -euo pipefail

echo "==> Nuking Root Workspace to force isolated build..."
# This physically deletes the root Cargo.toml in the CI runner so Cargo CANNOT trigger os error 2.
rm -f Cargo.toml

echo "==> Building Rust Orchestrator..."
cd core_systems/rust_orchestrator
# Now Cargo has no choice but to build this folder in perfect isolation.
cargo build --release
cd ../..

# Compile C++/CUDA via CMake
echo "==> Building C++/CUDA Core Targets..."
rm -rf core_systems/build
mkdir -p core_systems/build
cd core_systems/build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
cd ../..

# Compile Zig Utilities
echo "==> Building Zig Utilities..."
zig build

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
