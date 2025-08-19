const std = @import("std");
const utils = @import("utils.zig");

pub fn execute(alloc: std.mem.Allocator, input: []const u8) void {
    _ = alloc;
    _ = input;
}

pub fn tokenize(alloc: std.mem.Allocator, input: []const u8) ![]utils.Token {
    var lexer = _Lexer{ .src = input };
    var tokens = std.ArrayList(utils.Token).init(alloc);

    while (true) {
        const token = try lexer.nextToken();
        try tokens.append(token);
        if (token.type == .EOF) break;
    }

    return tokens.toOwnedSlice();
}

const _Lexer = struct {
    const self = @This();

    src: []const u8,
    i: usize = 0,

    //for error reporting
    line: usize = 1,
    col: usize = 1,

    ///Letter or underscore
    fn isAlpha(lexer: *@This()) bool {
        const c: u8 = lexer.src[lexer.i];
        return (c >= 'A' and c <= 'Z') or
            (c >= 'a' and c <= 'z') or
            (c == '_');
    }

    ///Letter, digit or undescore
    fn isAlphaNum(lexer: *@This()) bool {
        const c: u8 = lexer.src[lexer.i];
        return (c >= 'A' and c <= 'Z') or
            (c >= 'a' and c <= 'z') or
            (c >= '0' and c <= '9') or
            (c == '_');
    }

    ///Digit
    fn isDigit(lexer: *@This()) bool {
        const c: u8 = lexer.src[lexer.i];
        return c >= '0' and c <= '9';
    }

    //Peek wihtout consuming
    fn peek(lexer: *@This()) ?u8 {
        if (lexer.i < lexer.src.len) return lexer.src[lexer.i];
        return null;
    }

    ///Get char and advance
    fn advance(lexer: *@This()) ?u8 {
        if (lexer.i >= lexer.src.len) return null;
        const c = lexer.src[lexer.i];
        lexer.i += 1;
        lexer.col += 1;
        return c;
    }

    ///Skips whitespaces
    fn skipWhiteSpace(lexer: *@This()) void {
        while (lexer.i < lexer.src.len) {
            const c = lexer.src[lexer.i];
            if (!std.ascii.isWhitespace(c)) break;

            if (c == '\n') {
                lexer.col = 1;
                lexer.line += 1;
            } else {
                lexer.col += 1;
            }
            lexer.i += 1;
        }
    }

    fn scanWordForType(_: *@This(), word: []const u8) ?utils.TokenType {
        return switch (word.len) {
            1 => switch (word[0]) {
                ',' => if (std.mem.eql(u8, word, ",")) .COMMA else null,
                '*' => if (std.mem.eql(u8, word, "*")) .STAR else null,
                else => null,
            },
            3 => switch (word[0]) {
                'A' => if (std.mem.eql(u8, word, "AND")) .AND else null,
                'O' => if (std.mem.eql(u8, word, "OR")) .OR else null,
                else => null,
            },
            4 => switch (word[0]) {
                'F' => if (std.mem.eql(u8, word, "FROM")) .FROM else null,
                else => null,
            },
            5 => switch (word[0]) {
                'W' => if (std.mem.eql(u8, word, "WHERE")) .WHERE else null,
                else => null,
            },
            6 => switch (word[0]) {
                'S' => if (std.mem.eql(u8, word, "SELECT")) .SELECT else null,
                else => null,
            },
            else => null,
        };
    }

    pub fn nextToken(lexer: *@This()) !utils.Token {
        lexer.skipWhiteSpace();

        if (lexer.i >= lexer.src.len) {
            return utils.Token{ .type = .EOF, .lexeme = "", .position = @as(u8, @intCast(lexer.i)) };
        }

        const start: usize = lexer.i;
        const c = lexer.peek();

        if (c != null) {
            switch (c.?) {
                ',', '*', '>', '<', '=', '!', '+', '-', '/', '(', ')', ';' => {
                    _ = lexer.advance();
                    const lexeme: []const u8 = lexer.src[start..lexer.i];
                    const token_type = lexer.scanWordForType(lexeme) orelse .IDENTIFIER;
                    return utils.Token{ .type = token_type, .lexeme = lexeme, .position = @as(u8, @intCast(start)) };
                },
                else => {},
            }
        }

        var current = lexer.peek();
        while (current != null and !std.ascii.isWhitespace(current.?) and
            current.? != ',' and current.? != '*' and current.? != '>' and
            current.? != '<' and current.? != '=' and current.? != '!' and
            current.? != '+' and current.? != '-' and current.? != '/' and
            current.? != '(' and current.? != ')' and current.? != ';')
        {
            _ = lexer.advance();
            current = lexer.peek();
        }

        const lexeme: []const u8 = lexer.src[start..lexer.i];
        const token_type = lexer.scanWordForType(lexeme) orelse .IDENTIFIER;
        return utils.Token{ .type = token_type, .lexeme = lexeme, .position = @as(u8, @intCast(start)) };
    }
};

test "lexer.tokenize_simple_query" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const query = "SELECT * FROM users";
    std.debug.print("\n=== Testing SQL Query: '{s}' ===\n", .{query});

    const toks = try tokenize(alloc, query);
    defer alloc.free(toks);

    std.debug.print("Total tokens found: {}\n", .{toks.len});

    for (toks, 0..) |token, i| {
        std.debug.print("Token {}: Type={s}, Lexeme='{s}', Position={}\n", .{ i, token.type.toString(), token.lexeme, token.position });
    }

    try std.testing.expectEqual(@as(usize, 5), toks.len);
    try std.testing.expectEqual(utils.TokenType.SELECT, toks[0].type);
    try std.testing.expectEqual(utils.TokenType.STAR, toks[1].type);
    try std.testing.expectEqual(utils.TokenType.FROM, toks[2].type);
    try std.testing.expectEqual(utils.TokenType.IDENTIFIER, toks[3].type);
    try std.testing.expectEqual(utils.TokenType.EOF, toks[4].type);

    std.debug.print("=== Test passed! ===\n\n", .{});
}

test "lexer.tokenize_complex_query" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    const query = "SELECT name, age FROM users WHERE age > 18 AND active = true";
    std.debug.print("\n=== Testing Complex SQL Query: '{s}' ===\n", .{query});

    const toks = try tokenize(alloc, query);
    defer alloc.free(toks);

    std.debug.print("Total tokens found: {}\n", .{toks.len});

    for (toks, 0..) |token, i| {
        std.debug.print("Token {}: Type={s}, Lexeme='{s}', Position={}\n", .{ i, token.type.toString(), token.lexeme, token.position });
    }

    try std.testing.expect(toks.len > 10);

    try std.testing.expectEqual(utils.TokenType.SELECT, toks[0].type);
    try std.testing.expectEqual(utils.TokenType.FROM, toks[4].type);
    try std.testing.expectEqual(utils.TokenType.WHERE, toks[6].type);
    try std.testing.expectEqual(utils.TokenType.AND, toks[10].type);

    std.debug.print("=== Complex query test passed! ===\n\n", .{});
}
