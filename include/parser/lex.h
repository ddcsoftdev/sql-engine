#pragma once

#include <optional>
#include <string>
#include <vector>

#include "models/lexer/token.h"

namespace parser::lexer {

class Lexer {
  private:
    const char *buffer;
    unsigned int index;
    unsigned int row;
    unsigned int column;

  public:
    Lexer(std::string buffer) : buffer(buffer.c_str()), index(0), row(0), column(0) {}
    std::vector<models::lexer::Token> tokenize();

  private:
    char peek() const;
    char get();
    bool isSpace(char c);
    bool isDigit(char c);
    bool isAlphanum(char c);
    bool isSymbol(char c);
    bool isEndOfQuery(char c);
    bool findTokenAndAppend(std::optional<models::lexer::Token> token,
                            std::vector<models::lexer::Token> &tokens);
    std::optional<models::lexer::Token> findDelimiter();
    std::optional<models::lexer::Token> findKeyword();
    std::optional<models::lexer::Token> findIdentifier();
    std::optional<models::lexer::Token> findLiteral();
};
} // namespace parser::lexer