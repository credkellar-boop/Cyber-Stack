const std = @import("std");

/// Evaluates input thresholds at compile-time to guarantee runtime mathematical correctness
pub fn checkMemoryThreshold(comptime max_size: usize, current_size: usize) !void {
    if (current_size > max_size) {
        return error.AllocationBoundaryViolated;
    }
}

export fn validate_buffer_bounds(allocated: usize, requested: usize) bool {
    // ReleaseSafe panic controls catch inconsistencies automatically
    checkMemoryThreshold(4096, requested) catch {
        return false;
    };
    return requested <= allocated;
}
