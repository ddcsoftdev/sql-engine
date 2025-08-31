const std = @import("std");
const ErrorDetails = @import("errors.zig").ErrorDetails;
const columnWidth = @import("literals.zig").columnWidth;
const code_pages = @import("code_pages.zig");
const SupportedCodePage = code_pages.SupportedCodePage;
const SourceMappings = @import("source_mapping.zig").SourceMappings;
const isNonAsciiDigit = @import("utils.zig").isNonAsciiDigit;

const LexIdEnums = @import("enums.zig");

// NOTE: Lexer Types
pub const Token = struct {
    id: LexIdEnums.TokenId,
    start: usize,
    end: usize,
    line_number: usize,
    data: union {
        keyword: Keyword,
        identifier: Identifier,
        literal: Literal,
        delimiter: Delimiter,
    },

    ///Returns token word within the original buffer
    pub fn slice(self: Token, buffer: []const u8) []const u8 {
        return buffer[self.start..self.end];
    }

    pub fn getData(self: Token) switch (self.id) {
        .Keyword => Keyword,
        .Identifier => Identifier,
        .Literal => Literal,
        .Delimiter => Delimiter,
    } {
        return switch (self.id) {
            .Keyword => self.data.keyword,
            .Identifier => self.data.identifier,
            .Literal => self.data.literal,
            .Delimiter => self.data.delimiter,
        };
    }
};

pub const Keyword = struct {
    key_id: LexIdEnums.KeywordId,
};

pub const Identifier = struct {
    identif_id: LexIdEnums.IdentifierId,
};

pub const Literal = struct {
    literal_id: LexIdEnums.LiteralId,
};

pub const Delimiter = struct {
    delimiter_id: LexIdEnums.DelimiterId,
};

//NOTE: Main Lexer struct use for tokenizing
pub const LexError = error{
    UnfinishedStringLiteral,
    StringLiteralTooLong,
    InvalidNumberWithExponent,
    InvalidDigitCharacterInNumberLiteral,
    IllegalByte,
    IllegalByteOutsideStringLiterals,
    IllegalCodepointOutsideStringLiterals,
    IllegalByteOrderMark,
    IllegalPrivateUseCharacter,
    FoundCStyleEscapedQuote,
    CodePagePragmaMissingLeftParen,
    CodePagePragmaMissingRightParen,
    /// Can be caught and ignored
    CodePagePragmaInvalidCodePage,
    CodePagePragmaNotInteger,
    CodePagePragmaOverflow,
    CodePagePragmaUnsupportedCodePage,
    /// Can be caught and ignored
    CodePagePragmaInIncludedFile,
};

pub const Lexer = struct {
    const Self = @This();

    buffer: []const u8,
    index: usize,
    row: usize,
    column: usize,

    pub const Error = LexError;

    pub fn init(buffer: []const u8) Self {
        return Self{
            .buffer = buffer,
            .index = 0,
            .row = 0,
            .column = 0,
        };
    }

    pub fn tokenize(self: *Self) []Token {
        var tokens = std.ArrayList(Token).init(std.heap.page_allocator);
        defer tokens.deinit();

        while (self.index < self.buffer.len) {
            const c = self.peek();
            if (self.isEndOfQuery(c)) break;

            if (self.isWhitespace(c)) {
                _ = self.next();
                continue;
            }

            const token = getToken(c);
            if (token != null) tokens.append(token);

            _ = self.next();
        }

        return tokens.toOwnedSlice();
    }

    pub fn dump(self: *Self, token: *const Token) void {
        std.debug.print("{s}:{d}: {f}\n", .{
            @tagName(token.id), token.line_number, std.ascii.hexEscape(token.slice(self.buffer), .lower),
        });
    }

    pub fn peek(self: Self) u8 {
        return if (self.index < self.buffer.len)
            self.buffer[self.index]
        else
            0;
    }

    pub fn next(self: *Self) u8 {
        const c = if (self.index < self.buffer.len)
            self.buffer[self.index]
        else
            0;

        if (std.ascii.isControl(c)) {
            if (c == '\n') {
                self.column = 0;
                self.row += 1;
            }
        } else {
            self.column += 1;
        }
        self.index += 1;
        return c;
    }

    pub fn isAlphaNum(c: u8) bool {
        return std.ascii.isAlphabetic(c) or std.ascii.isDigit(c);
    }

    pub fn isAlpha(c: u8) bool {
        return std.ascii.isAlphabetic(c);
    }

    pub fn isWhitespace(c: u8) bool {
        return std.ascii.isWhitespace(c);
    }

    pub fn isSymbol(c: u8) bool {
    return switch (c) {
        '!'...'/', ':'...'@', '['...'`', '{'...'~' => true,
        else => false,
    };
}

    pub fn isEndOfQuery(c: u8) bool {
        return c == 0 or c == ';';
    }

    pub fn getToken(self: *Self, c: u8) ?*Token{
        if (self.isSymbol(c)) {
            return self.checkForDelimiter();
        }
        
        if (self.isAlpha(c)) {
            return self.checkForKeyword() orelse self.checkForIdentifier();
        }
        
        return self.checkForLiteral();
    }

    pub fn checkForKeyword(self: *Self) ?*Token {
        _ = self;
    }

    pub fn checkForIdentifier(self: *Self) ?*Token {
        _ = self;
    }

    pub fn checkForLiteral(self: *Self) ?*Token {
        _ = self;
    }

    pub fn checkForDelimiter(self: *Self) ?*Token {
        _ = self;
    }
};

//NOTE: Tests for lexer below
pub fn tester() void {
    
}
