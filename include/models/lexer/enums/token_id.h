#pragma once

#include <string>

namespace models::lexer::enums {

enum class TokenId { Literal, Keyword, Identifier, Delimiter, EndOfFile };

inline std::string toString(TokenId id) {
    switch (id) {
    case TokenId::Literal:
        return "<literal>";
    case TokenId::Keyword:
        return "<keyword>";
    case TokenId::Identifier:
        return "<identifier>";
    case TokenId::Delimiter:
        return "<delimiter>";
    case TokenId::EndOfFile:
        return "<eof>";
    }
    return "<unknown>";
}

} // namespace models::lexer::enums
