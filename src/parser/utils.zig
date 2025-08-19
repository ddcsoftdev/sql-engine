pub const TokenType = enum {
    SELECT,
    FROM,
    WHERE,
    AND,
    OR,
    COMMA,
    STAR,
    OP,
    INDENT,
    NUMBER,
    STRING,
    EOF,
    IDENTIFIER,

    pub fn toString(self: TokenType) []const u8 {
        return token_type_names[@intFromEnum(self)];
    }
};

const token_type_names = [_][]const u8{
    "SELECT",
    "FROM",
    "WHERE",
    "AND",
    "OR",
    "COMMA",
    "STAR",
    "OP",
    "INDENT",
    "NUMBER",
    "STRING",
    "EOF",
    "IDENTIFIER",
};

pub const Token = struct {
    type: TokenType,
    lexeme: []const u8,
    position: u8,
};
