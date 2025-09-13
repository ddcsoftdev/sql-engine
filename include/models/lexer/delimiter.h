#pragma once

#include "enums/delimiter_id.h"
#include "enums/token_id.h"
#include "token.h"
#include <cstdint>

namespace models::lexer {

struct Delimiter : public Token {
    enums::DelimiterId delimiterId;

    Delimiter(enums::DelimiterId delimiterId, uint16_t start, uint16_t end, uint16_t lineNumber)
        : Token(enums::TokenId::Delimiter, start, end, lineNumber), delimiterId(delimiterId) {}
};

} // namespace models::lexer