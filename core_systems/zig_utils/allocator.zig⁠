const std = @import("std");

pub const CyberArena = struct {
    buffer: []u8,
    fba: std.heap.FixedBufferAllocator,
    allocator: std.mem.Allocator,

    pub fn init(memory_block: []u8) CyberArena {
        var fba = std.heap.FixedBufferAllocator.init(memory_block);
        return CyberArena{
            .buffer = memory_block,
            .fba = fba,
            .allocator = fba.allocator(),
        };
    }

    pub fn reset(self: *CyberArena) void {
        self.fba.reset();
    }
};

export fn setup_secure_arena(buffer_ptr: [*]u8, size: usize) void {
    // FFI integration for Rust/C passing raw memory into Zig's strict management
    var slice = buffer_ptr[0..size];
    _ = CyberArena.init(slice);
}
