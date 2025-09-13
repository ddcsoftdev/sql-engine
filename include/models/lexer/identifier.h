#pragma once

#include "enums/identifier_id.h"
#include "enums/token_id.h"
#include "token.h"
#include <cstdint>

namespace models::lexer {

struct Identifier : public Token {
    enums::IdentifierId identifierId;

    Identifier(enums::IdentifierId identifierId, uint16_t start, uint16_t end, uint16_t lineNumber)
        : Token(enums::TokenId::Identifier, start, end, lineNumber), identifierId(identifierId) {}
};

} // namespace models::lexer