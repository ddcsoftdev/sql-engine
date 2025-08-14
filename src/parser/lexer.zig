const std = @import("std");

pub fn execute(alloc: std.mem.Allocator, input: []const u8) void {
    _ = alloc;
    _ = input;
}

fn tokenize(alloc: std.mem.Allocator, input: []const u8) ![]const []const u8 {
    var out = std.ArrayList([]const u8).init(alloc);
    errdefer {
        for (out.items) |w| alloc.free(w);
        out.deinit();
    }

    var it = std.mem.tokenizeAny(u8, input, " \t\r\n");
    while (it.next()) |tok| {
        const dup = try alloc.dupe(u8, tok); // make an owned copy
        try out.append(dup);
    }
    return try out.toOwnedSlice();
}

test "lexer.tokenize" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const msg = "STR   !@#\t1 \n  STR";
    const toks = try .okenize(alloc, msg);
    defer {
        for (toks) |w| alloc.free(w);
        alloc.free(toks);
    }

    try std.testing.expectEqual(@as(usize, 4), toks.len);
    try std.testing.expectEqualStrings("STR", toks[0]);
    try std.testing.expectEqualStrings("!@#", toks[1]);
    try std.testing.expectEqualStrings("1", toks[2]);
    try std.testing.expectEqualStrings("STR", toks[3]);
}
