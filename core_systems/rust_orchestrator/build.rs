#!/bin/bash
set -e

# 1. Compile the Zig static library inside its own module directory
cd core_systems/zig_utils
zig build --summary all

# 2. Return to the repository root and compile the Rust workspace
cd ../..
cargo build --release
