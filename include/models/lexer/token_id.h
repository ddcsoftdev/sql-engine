namespace models {
namespace lexer {

enum class TokenId {
    Literal,
    Keyword,
    Identifier,
    EndOfFile
}

inline std::string
toString(TokenId id) {
    switch (id) {
    case TokenId::Literal:
        return "<literal>";
    case TokenId::Keyword:
        return "<keyword>";
    case TokenId::Identifier:
        return "<identifier>";
    case TokenId::EndOfFile:
        return "<eof>";
    }
    return "<unknown>"
}

} // namespace lexer
} // namespace models