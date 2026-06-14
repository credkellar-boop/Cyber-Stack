const std = @import("std");

/// Returns true if the target signature is found within the payload
export fn fast_signature_scan(payload_ptr: [*]const u8, payload_len: usize, sig_ptr: [*]const u8, sig_len: usize) bool {
    if (sig_len > payload_len) return false;

    const payload = payload_ptr[0..payload_len];
    const signature = sig_ptr[0..sig_len];

    // Utilize Zig's standard library optimized byte searching
    if (std.mem.indexOf(u8, payload, signature)) |_| {
        return true;
    }
    
    return false;
}
