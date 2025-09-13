#include "parser/lex.h"

#include "models/lexer/enums/delimiter_id.h"
#include "models/lexer/enums/keyword_id.h"
#include <algorithm>

using namespace parser::lexer;
using namespace models::lexer;
using namespace models::lexer::enums;

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

bool Lexer::findTokenAndAppend(std::optional<Token> token,
                      std::vector<Token> &tokens) {
    if (token.has_value()) {
        tokens.push_back(token.value());
        return true;
    }
    return false;
}

std::optional<Token> Lexer::findDelimiter(){
    char c = peek();
    
    auto delimiterId = enums::fromChar(c);
    if (delimiterId.has_value()) {
        get(); // consume the character
        return Token(enums::TokenId::Delimiter, index - 1, index, row);
    }
    
    return std::nullopt;
}

std::optional<Token> Lexer::findKeyword() {
    const char* start = buffer;
    std::string word;
    
    // Read the word
    while (isAlphanum(*buffer)) {
        word += *buffer;
        get();
    }
    
    if (word.empty()) {
        return std::nullopt;
    }
    
    // Convert to uppercase for keyword matching
    std::transform(word.begin(), word.end(), word.begin(), ::toupper);
    
    auto keywordId = enums::fromString(word);
    if (keywordId.has_value()) {
        return Token(enums::TokenId::Keyword, start - buffer, buffer - start, row);
    }
    
    // Reset buffer position if not a keyword
    buffer = start;
    return std::nullopt;
}

std::optional<Token> Lexer::findIdentifier() {
    const char* start = buffer;
    std::string identifier;
    
    // Read the identifier (must start with letter or underscore)
    if (!isAlphanum(*buffer) && *buffer != '_') {
        return std::nullopt;
    }
    
    while (isAlphanum(*buffer) || *buffer == '_') {
        identifier += *buffer;
        get();
    }
    
    if (identifier.empty()) {
        return std::nullopt;
    }
    
    // Check if it's actually a keyword (case-insensitive)
    std::string upperIdentifier = identifier;
    std::transform(upperIdentifier.begin(), upperIdentifier.end(), upperIdentifier.begin(), ::toupper);
    
    if (enums::fromString(upperIdentifier).has_value()) {
        // It's a keyword, not an identifier
        buffer = start;
        return std::nullopt;
    }
    
    return Token(enums::TokenId::Identifier, start - buffer, buffer - start, row);
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
