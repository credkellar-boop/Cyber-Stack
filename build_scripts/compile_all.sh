#!/bin/bash
set -euo pipefail

echo "==> Building Rust Orchestrator..."
# Move completely out of the root context into the directory
cd core_systems/rust_orchestrator

# Force cargo to ignore the parent workspace definitions entirely
# by targeting the local package directly.
cargo build --release --package cyber_stack_orchestrator

# Return to root directory for the remaining builds
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
zig build --build-file core_systems/zig_utils/build.zig

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
