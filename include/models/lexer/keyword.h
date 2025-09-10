#pragma once

namespace models::lexer {

struct Keword: public Token{
    enums::KewwordId keyId;

    KeywordToken(enums::KewwordId keyId, uint16_t start, uint16_t end, uint16_t lineNumber)
        : Token(enums::TokenId::Keyword, start, end, line), keyId(keyId) {}
};

} // namespace models::lexer