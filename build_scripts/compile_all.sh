set -euo pipefail

echo "==> Compiling Core Cyber-Stack Workspace"

# 1. Compile Rust Modules
echo "==> Building Rust Orchestrator..."
# Move into the directory first, then build
cd core_systems/rust_orchestrator
cargo build --release
cd ../.. # Return to root

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
