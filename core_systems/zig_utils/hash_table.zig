const std = @import("std");

pub const ConnectionState = struct {
    ip: u32,
    packets: u64,
};

pub fn update_connection(map: *std.AutoHashMap(u32, u64), ip: u32) !void {
    const entry = try map.getOrPut(ip);
    if (!entry.found_existing) entry.value_ptr.* = 0;
    entry.value_ptr.* += 1;
}
