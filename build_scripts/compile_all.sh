#!/bin/bash
set -euo pipefail

# Force absolute path using GITHUB_WORKSPACE to avoid relative pathing errors
MANIFEST_PATH="$GITHUB_WORKSPACE/core_systems/rust_orchestrator/Cargo.toml"

echo "==> Debugging: Looking for manifest at $MANIFEST_PATH"

if [ ! -f "$MANIFEST_PATH" ]; then
  echo "Error: Manifest not found at $MANIFEST_PATH"
  ls -R "$GITHUB_WORKSPACE/core_systems"
  exit 1
fi

echo "==> Building Rust Orchestrator..."
cargo build --manifest-path "$MANIFEST_PATH" --release

# 2. Compile C++/CUDA via CMake
echo "==> Building C++/CUDA Core Targets..."
rm -rf "$GITHUB_WORKSPACE/core_systems/build"
mkdir -p "$GITHUB_WORKSPACE/core_systems/build"
cd "$GITHUB_WORKSPACE/core_systems/build"
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
cd "$GITHUB_WORKSPACE"

# 3. Compile Zig Utilities
echo "==> Building Zig Utilities..."
zig build --build-file "$GITHUB_WORKSPACE/core_systems/zig_utils/build.zig"

echo "==> ✅ All Cyber-Stack Subsystems Built Successfully!"
