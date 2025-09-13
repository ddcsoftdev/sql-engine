#pragma once

#include "enums/token_id.h"
#include <cstdint>

namespace models::lexer {

struct Token {
    enums::TokenId id;
    uint16_t start;
    uint16_t end;
    uint16_t lineNumber;

    Token(enums::TokenId id, uint16_t start, uint16_t end, uint16_t lineNumber)
        : id(id), start(start), end(end), lineNumber(lineNumber) {}
};

} // namespace models::lexer