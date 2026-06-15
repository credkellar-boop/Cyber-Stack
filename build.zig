const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Compiling zig_utils as a static library
    const lib = b.addStaticLibrary(.{
        .name = "zig_utils",
        // FIX: Changed from b.path() to the 0.11.0 anonymous struct style
        .root_source_file = .{ .path = "core_systems/zig_utils/src/main.zig" }, 
        .target = target,
        .optimize = optimize,
    });

    // Directs the static library binary output to your build directory
    b.installArtifact(lib);
}
