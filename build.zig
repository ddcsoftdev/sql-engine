const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "hello",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = b.graph.host,
        }),
    });

    b.installArtifact(exe);

    // Add a run step
    const run_cmd = b.addRunArtifact(exe);
    b.step("run", "Run the hello program").dependOn(&run_cmd.step);
}
