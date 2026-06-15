use std::env;
use std::path::Path;

fn main() {
    let manifest_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let package_path = Path::new(&manifest_dir);

    // Step out of core_systems/rust_orchestrator to find the root zig-out folder
    let zig_lib_dir = package_path
        .parent() // core_systems/
        .unwrap()
        .parent() // Cyber-Stack/ (root)
        .unwrap()
        .join("zig-out")
        .join("lib");

    println!("cargo:rustc-link-search=native={}", zig_lib_dir.display());
    println!("cargo:rustc-link-lib=static=zig_utils");
    println!("cargo:rerun-if-changed=build.rs");
}
