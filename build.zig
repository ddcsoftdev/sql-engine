const std = @import("std");

const app_name = "sql-engine";
const version = "1.0.0";

pub fn build(b: *std.Build) void {
    const optimize = b.standardOptimizeOption(.{});
    const target = b.standardTargetOptions(.{});

    const exe = b.addExecutable(.{
        .name = app_name,
        .root_source_file = b.path("src/main.zig"),
        .optimize = optimize,
        .target = target,
    });
    b.installArtifact(exe);

    // Add run command
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
