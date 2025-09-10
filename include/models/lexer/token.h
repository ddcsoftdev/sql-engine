#pragma once

namespace models::lexer {

struct Token {
    enums::TokenId id;
    uint16_t start;
    uint16_t end;
    uint16_t lineNumber;
};

} // namespace models::lexer