#pragma once

#include "enums/keyword_id.h"
#include "enums/token_id.h"
#include "token.h"
#include <cstdint>

namespace models::lexer {

struct Keyword : public Token {
    enums::KeywordId keyId;

    Keyword(enums::KeywordId keyId, uint16_t start, uint16_t end, uint16_t lineNumber)
        : Token(enums::TokenId::Keyword, start, end, lineNumber), keyId(keyId) {}
};

} // namespace models::lexer