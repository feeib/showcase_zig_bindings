const std: type = @import("std");

pub fn build(bld: *std.Build) void {
    const target: std.Build.ResolvedTarget = bld.standardTargetOptions(.{});
    const optimize: std.builtin.OptimizeMode = bld.standardOptimizeOption(.{});

    const godot_mod: *std.Build.Module = bld.createModule(.{
        .root_source_file = bld.path("../godot-zig/godot.zig"),
        .target = target,
        .optimize = optimize,
    });

    const lib: *std.Build.Step.Compile = bld.addLibrary(.{
        .name = "godot_zig",
        .linkage = .dynamic,
        .root_module = bld.createModule(.{
            .root_source_file = bld.path("lib.zig"),
            .target = target,
            .optimize = optimize,
            .link_libc = true,
            .imports = &.{.{
                .name = "godot",
                .module = godot_mod,
            }},
        }),
    });

    bld.installArtifact(lib);
}
