const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "zig_utils",
        .root_source_file = b.path("core_systems/zig_utils/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(lib);
}
