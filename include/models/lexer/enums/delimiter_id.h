#pragma once

#include <string>

namespace models::lexer::enums {

enum class DelimiterId {
    LeftParen,
    RightParen,
    LeftBracket,
    RightBracket,
    LeftBrace,
    RightBrace,
    Comma,
    Semicolon,
    Period,
    Colon,
    DoubleColon,
    Asterisk,
    Plus,
    Minus,
    Slash,
    Percent,
    Equal,
    NotEqual,
    LessThan,
    GreaterThan,
    LessThanOrEqual,
    GreaterThanOrEqual,
    Ampersand,
    VerticalBar,
    Exclamation,
    Tilde,
    Caret,
    QuestionMark,
    At,
    Hash,
    Dollar,
    Backslash,
    Quote,
    DoubleQuote,
    Backtick,
    Space,
    Tab,
    Newline,
    CarriageReturn
};

inline std::string toString(DelimiterId id) {
    switch (id) {
    case DelimiterId::LeftParen:
        return "(";
    case DelimiterId::RightParen:
        return ")";
    case DelimiterId::LeftBracket:
        return "[";
    case DelimiterId::RightBracket:
        return "]";
    case DelimiterId::LeftBrace:
        return "{";
    case DelimiterId::RightBrace:
        return "}";
    case DelimiterId::Comma:
        return ",";
    case DelimiterId::Semicolon:
        return ";";
    case DelimiterId::Period:
        return ".";
    case DelimiterId::Colon:
        return ":";
    case DelimiterId::DoubleColon:
        return "::";
    case DelimiterId::Asterisk:
        return "*";
    case DelimiterId::Plus:
        return "+";
    case DelimiterId::Minus:
        return "-";
    case DelimiterId::Slash:
        return "/";
    case DelimiterId::Percent:
        return "%";
    case DelimiterId::Equal:
        return "=";
    case DelimiterId::NotEqual:
        return "!=";
    case DelimiterId::LessThan:
        return "<";
    case DelimiterId::GreaterThan:
        return ">";
    case DelimiterId::LessThanOrEqual:
        return "<=";
    case DelimiterId::GreaterThanOrEqual:
        return ">=";
    case DelimiterId::Ampersand:
        return "&";
    case DelimiterId::VerticalBar:
        return "|";
    case DelimiterId::Exclamation:
        return "!";
    case DelimiterId::Tilde:
        return "~";
    case DelimiterId::Caret:
        return "^";
    case DelimiterId::QuestionMark:
        return "?";
    case DelimiterId::At:
        return "@";
    case DelimiterId::Hash:
        return "#";
    case DelimiterId::Dollar:
        return "$";
    case DelimiterId::Backslash:
        return "\\";
    case DelimiterId::Quote:
        return "'";
    case DelimiterId::DoubleQuote:
        return "\"";
    case DelimiterId::Backtick:
        return "`";
    case DelimiterId::Space:
        return " ";
    case DelimiterId::Tab:
        return "\t";
    case DelimiterId::Newline:
        return "\n";
    case DelimiterId::CarriageReturn:
        return "\r";
    }
    return "<unknown>";
}

} // namespace models::lexer::enums
