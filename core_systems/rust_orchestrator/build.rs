#!/bin/bash
set -e

# 1. Compile the Zig static library inside its own module directory
cd core_systems/zig_utils
zig build --summary all

# 2. Return to the repository root and compile the Rust workspace
cd ../..
cargo build --release

use std::env;
use std::path::Path;

fn main() {
    let manifest_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let package_path = Path::new(&manifest_dir);

    // Navigates to core_systems/zig_utils/zig-out/lib/
    let zig_lib_dir = package_path
        .parent() // core_systems/
        .unwrap()
        .join("zig_utils")
        .join("zig-out")
        .join("lib");

    println!("cargo:rustc-link-search=native={}", zig_lib_dir.display());
    println!("cargo:rustc-link-lib=static=zig_utils");
    println!("cargo:rerun-if-changed=build.rs");
}
