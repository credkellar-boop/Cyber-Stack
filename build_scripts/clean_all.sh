#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo "🧹 Cleaning Core Cyber-Stack Workspace"
echo "=================================================="

# Clean Rust Workspace
echo "-> Cleaning Cargo target directory..."
cargo clean

# Clean C/C++/CUDA Workspace
echo "-> Removing CMake build directory..."
rm -rf core_systems/build

# Clean Zig Workspace
echo "-> Removing Zig cache and output directories..."
rm -rf core_systems/zig-cache
rm -rf core_systems/zig-out

# Clean eBPF Object files
echo "-> Removing compiled eBPF/XDP objects..."
rm -f low_level_perf/kernel_hooks/ebpf/*.o

echo "=================================================="
echo "✨ Workspace thoroughly cleaned."
echo "=================================================="
