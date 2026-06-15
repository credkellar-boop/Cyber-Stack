const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zig_utils",
        // Fixed: Points directly to main.zig in this directory
        .root_source_file = .{ .path = "main.zig" },
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);
}
