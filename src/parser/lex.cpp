#include "parser/lex.h"

using namespace parser::lexer;
using namespace models::lexer;

std::vector<Token> Lexer::tokenize() {
    std::vector<Token> tokens;

    while (!isEndOfQuery(*buffer)) {
        char c = *buffer;
        while (isSpace(c)) {
            get();
        }

        if (isSymbol(c)) {
            if (findTokenAndAppend(findDelimiter(), tokens)) {
                continue;
            }
        }

        if (isAlphanum(c)) {
            if (findTokenAndAppend(findKeyword(), tokens)) {
                continue;
            }

            if (findTokenAndAppend(findIdentifier(), tokens)) {
                continue;
            }
        }

        findTokenAndAppend(findLiteral(), tokens);
    }

    return tokens;
}

bool Lexer::findTokenAndAppend(std::optional<models::lexer::Token> token,
                      std::vector<models::lexer::Token> &tokens) {
    if (token.has_value()) {
        tokens.push_back(token.value());
        return true;
    }
    return false;
}

char Lexer::peek() const { return *buffer; }

char Lexer::get() { return *buffer++; }

bool Lexer::isSpace(char c) {
    switch (c) {
    case ' ':
    case '\t':
    case '\r':
    case '\n':
        return true;
    default:
        return false;
    }
}

bool Lexer::isDigit(char c) { return (c >= '0' && c <= '9'); }

bool Lexer::isAlphanum(char c) {
    return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

bool Lexer::isSymbol(char c) {
    return (c >= '!' && c <= '/') || (c >= ':' && c <= '@') || (c >= '[' && c <= '`') ||
           (c >= '{' && c <= '~');
}

bool Lexer::isEndOfQuery(char c) { return c == '\0' || c == ';'; }
