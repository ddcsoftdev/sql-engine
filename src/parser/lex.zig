const std = @import("std");
const ErrorDetails = @import("errors.zig").ErrorDetails;
const columnWidth = @import("literals.zig").columnWidth;
const code_pages = @import("code_pages.zig");
const SupportedCodePage = code_pages.SupportedCodePage;
const SourceMappings = @import("source_mapping.zig").SourceMappings;
const isNonAsciiDigit = @import("utils.zig").isNonAsciiDigit;

const LexIdEnums = @import("enums.zig");

pub const Token = struct {
    id: LexIdEnums.TokenId,
    start: usize,
    end: usize,
    line_number: usize,

    


    pub fn slice(self: Token, buffer: []const u8) []const u8{
        return buffer[self.start..self.end];
    }
};

pub const Keyword = struct {
    base: Token,
    key_id: LexIdEnums.KeywordId,

};

pub const Identifier = struct {
    base: Token,
    identif_id: LexIdEnums.IdentifierId,

};

pub const Literal = struct {
    base: Token,
    literal_id: LexIdEnums.LiteralId,

};


//? Tests for class below

pub fn tester() void{
   const key = Keyword;
   _=key;
   key.base.start;


}


