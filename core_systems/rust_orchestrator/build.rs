use std::env;
use std::path::PathBuf;

fn main() {
    let project_dir = env::var("CARGO_MANIFEST_DIR").unwrap();
    let root_dir = PathBuf::from(&project_dir).parent().unwrap().parent().unwrap().to_path_buf();

    // Link Zig memory utilities
    println!("cargo:rustc-link-search=native={}/core_systems/zig-out/lib", root_dir.display());
    println!("cargo:rustc-link-lib=static=zig_utils");

    // Link CUDA acceleration objects
    println!("cargo:rustc-link-search=native={}/core_systems/build/cuda_acceleration", root_dir.display());
    println!("cargo:rustc-link-lib=static=cuda_acceleration");

    // Link DPDK pipeline objects
    println!("cargo:rustc-link-search=native={}/core_systems/build/low_level_perf/dpdk_pipeline", root_dir.display());
    println!("cargo:rustc-link-lib=static=dpdk_pipeline");

    // Force rebuild if external library directories change
    println!("cargo:rerun-if-changed={}/core_systems/zig-out/lib", root_dir.display());
    println!("cargo:rerun-if-changed={}/core_systems/build", root_dir.display());
}
