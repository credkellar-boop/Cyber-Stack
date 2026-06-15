use std::env;
use std::path::PathBuf;

fn main() {
    // 1. Get the absolute path to core_systems/rust_orchestrator
    let manifest_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let mut core_systems_dir = PathBuf::from(manifest_dir);
    core_systems_dir.pop(); // Step up to core_systems/

    // 2. Point to where the Zig compiler dumps the static library
    // (Standard Zig layout puts it in zig_utils/zig-out/lib/)
    let zig_lib_path = core_systems_dir.join("zig_utils").join("zig-out").join("lib");

    // 3. Pass the missing -L flag to Cargo
    println!("cargo:rustc-link-search=native={}", zig_lib_path.display());

    // 4. Link the static library
    println!("cargo:rustc-link-lib=static=zig_utils");

    // Re-run this script only if build.rs itself changes
    println!("cargo:rerun-if-changed=build.rs");
}
