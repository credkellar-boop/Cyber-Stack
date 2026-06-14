#!/bin/bash
set -euo pipefail

echo "==> Building Rust Orchestrator..."

# 1. Change directory to the specific project folder.
# This makes Cargo treat this folder as the root for the build,
# completely bypassing any workspace pathing issues.
cd core_systems/rust_orchestrator

# 2. Build the package directly.
# By being inside the folder, Cargo automatically finds the local Cargo.toml
# without needing --manifest-path.
cargo build --release

# 3. Return to root
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
zig build

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
