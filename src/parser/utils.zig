const TokenType = enum {
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
    NONE,

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
    "NONE",
};

const Token = struct {
    type: TokenType,
    lexeme: []const u8,
    position: u8,
};

///Letter or underscore
pub fn is_alpha(c: u8) bool {
    return (c >= 'A' and c <= 'Z') or
        (c >= 'a' and c <= 'z') or
        (c == '_');
}

///Letter, digit or undescore
pub fn is_alphanum(c: u8) bool {
    return (c >= 'A' and c <= 'Z') or
        (c >= 'a' and c <= 'z') or
        (c >= '0' and c <= '9') or
        (c == '_');
}

///Digit
pub fn is_digit(c: u8) bool {
    return (c >= '0' and c <= '9');
}
