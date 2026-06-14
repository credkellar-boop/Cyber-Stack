use std::os::raw::c_float;

#[link(name = "zig_utils")]
extern "C" {
    /// Safe boundary check exported from our native Zig memory utility stack
    pub fn validate_buffer_bounds(allocated: usize, requested: usize) -> bool;
}

#[link(name = "cuda_acceleration")]
extern "C" {
    /// Interoperability interface invoking the custom GPU weight scaler
    pub fn launchWeightScaler(d_matrix: *mut c_float, scale: c_float, size: i32);
}

pub fn check_system_bounds(alloc: usize, req: usize) -> bool {
    // Wrap FFI invocations inside safe boundaries
    unsafe { validate_buffer_bounds(alloc, req) }
}
