const std = @import("std");
const ErrorDetails = @import("errors.zig").ErrorDetails;
const columnWidth = @import("literals.zig").columnWidth;
const code_pages = @import("code_pages.zig");
const SupportedCodePage = code_pages.SupportedCodePage;
const SourceMappings = @import("source_mapping.zig").SourceMappings;
const isNonAsciiDigit = @import("utils.zig").isNonAsciiDigit;

pub const Token = struct {
    id: Id,
    start: usize,
    end: usize,
    line_number: usize,

    pub const Id = enum { LITERAL, KEYWORD, IDENTIFIER };


    pub fn slice(self: Token, buffer: []const u8) []const u8{
        return buffer[self.start..self.end];
    }
};

pub const Keyword = struct {
    base: Token,
    key_id: KeyId,

    pub const KeyId = enum {
        ALIAS,
        ALTER,
        ALL,
        AND,
        ANY,
        AS,
        ASC,
        AVG,

        BETWEEN,
        BEGIN,
        BIND,
        BIT,
        BOTH,
        BY,

        CASE,
        CHAR,
        CHARACTER,
        CHECK,
        CLOSE,
        COALESCE,
        COLEFTCH,
        COMMIT,
        CONNECT,
        COUNT,

    };
};


//? Tests for class below

pub fn tester() void{
   const key = Keyword;
   _=key;
   key.base.start;


}


