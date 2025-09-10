#pragma once

namespace models::lexer::enums {

enum class KeywordId {
    Alias,
    Alter,
    All,
    And,
    Any,
    As,
    Asc,
    Avg,

    Between,
    Begin,
    Bind,
    Bit,
    Both,
    By,

    Case,
    Char,
    Character,
    Check,
    Close,
    Coalesce,
    Coleftch,
    Commit,
    Connect,
    Count,
    Create,
    Current,

    Database,
    Date,
    Datetime,
    Dec,
    Decimal,
    Declare,
    Delete,
    Desc,
    Distinct,
    Double,
    Drop,

    Else,
    End,
    Escape,
    Except,
    Execute,
    Exists,

    Fetch,
    File,
    Float,
    For,
    From,

    Graphic,
    Group,

    Having,

    Image,
    In,
    Inner,
    Insert,
    Int,
    Integer,
    Intersect,
    Into,
    Is,

    Join,

    Key,

    Leading,
    Left,
    Like,
    Logical,
    Long,

    Max,
    Min,
    Money,

    Not,
    Null,
    Nullif,
    Number,
    Numeric,

    Of,
    Off,
    Open,
    On,
    Only,
    Option,
    Or,
    Order,
    Outer,

    Precision,
    Primary,

    Raw,
    Real,
    Reference,
    Right,
    Rollback,

    Select,
    Serial,
    Set,
    Smallfloat,
    Smallint,
    Some,
    Sqlid,
    Sum,
    Sysname,

    Table,
    Text,
    Time,
    Timestamp,
    Timezone,
    To,

    User,
    Union,
    Unique,
    UserTypeName,
    Using,
    Update,
}

inline std::string
toString(KeywordId id) {
    switch (id) {
    case KeywordId::Alias:
        return "ALIAS";
    case KeywordId::Alter:
        return "ALTER";
    case KeywordId::All:
        return "ALL";
    case KeywordId::And:
        return "AND";
    case KeywordId::Any:
        return "ANY";
    case KeywordId::As:
        return "AS";
    case KeywordId::Asc:
        return "ASC";
    case KeywordId::Avg:
        return "AVG";
    case KeywordId::Between:
        return "BETWEEN";
    case KeywordId::Begin:
        return "BEGIN";
    case KeywordId::Bind:
        return "BIND";
    case KeywordId::Bit:
        return "BIT";
    case KeywordId::Both:
        return "BOTH";
    case KeywordId::By:
        return "BY";
    case KeywordId::Case:
        return "CASE";
    case KeywordId::Char:
        return "CHAR";
    case KeywordId::Character:
        return "CHARACTER";
    case KeywordId::Check:
        return "CHECK";
    case KeywordId::Close:
        return "CLOSE";
    case KeywordId::Coalesce:
        return "COALESCE";
    case KeywordId::Coleftch:
        return "COLEFTCH";
    case KeywordId::Commit:
        return "COMMIT";
    case KeywordId::Connect:
        return "CONNECT";
    case KeywordId::Count:
        return "COUNT";
    case KeywordId::Create:
        return "CREATE";
    case KeywordId::Current:
        return "CURRENT";
    case KeywordId::Database:
        return "DATABASE";
    case KeywordId::Date:
        return "DATE";
    case KeywordId::Datetime:
        return "DATETIME";
    case KeywordId::Dec:
        return "DEC";
    case KeywordId::Decimal:
        return "DECIMAL";
    case KeywordId::Declare:
        return "DECLARE";
    case KeywordId::Delete:
        return "DELETE";
    case KeywordId::Desc:
        return "DESC";
    case KeywordId::Distinct:
        return "DISTINCT";
    case KeywordId::Double:
        return "DOUBLE";
    case KeywordId::Drop:
        return "DROP";
    case KeywordId::Else:
        return "ELSE";
    case KeywordId::End:
        return "END";
    case KeywordId::Escape:
        return "ESCAPE";
    case KeywordId::Except:
        return "EXCEPT";
    case KeywordId::Execute:
        return "EXECUTE";
    case KeywordId::Exists:
        return "EXISTS";
    case KeywordId::Fetch:
        return "FETCH";
    case KeywordId::File:
        return "FILE";
    case KeywordId::Float:
        return "FLOAT";
    case KeywordId::For:
        return "FOR";
    case KeywordId::From:
        return "FROM";
    case KeywordId::Graphic:
        return "GRAPHIC";
    case KeywordId::Group:
        return "GROUP";
    case KeywordId::Having:
        return "HAVING";
    case KeywordId::Image:
        return "IMAGE";
    case KeywordId::In:
        return "IN";
    case KeywordId::Inner:
        return "INNER";
    case KeywordId::Insert:
        return "INSERT";
    case KeywordId::Int:
        return "INT";
    case KeywordId::Integer:
        return "INTEGER";
    case KeywordId::Intersect:
        return "INTERSECT";
    case KeywordId::Into:
        return "INTO";
    case KeywordId::Is:
        return "IS";
    case KeywordId::Join:
        return "JOIN";
    case KeywordId::Key:
        return "KEY";
    case KeywordId::Leading:
        return "LEADING";
    case KeywordId::Left:
        return "LEFT";
    case KeywordId::Like:
        return "LIKE";
    case KeywordId::Logical:
        return "LOGICAL";
    case KeywordId::Long:
        return "LONG";
    case KeywordId::Max:
        return "MAX";
    case KeywordId::Min:
        return "MIN";
    case KeywordId::Money:
        return "MONEY";
    case KeywordId::Not:
        return "NOT";
    case KeywordId::Null:
        return "NULL";
    case KeywordId::Nullif:
        return "NULLIF";
    case KeywordId::Number:
        return "NUMBER";
    case KeywordId::Numeric:
        return "NUMERIC";
    case KeywordId::Of:
        return "OF";
    case KeywordId::Off:
        return "OFF";
    case KeywordId::Open:
        return "OPEN";
    case KeywordId::On:
        return "ON";
    case KeywordId::Only:
        return "ONLY";
    case KeywordId::Option:
        return "OPTION";
    case KeywordId::Or:
        return "OR";
    case KeywordId::Order:
        return "ORDER";
    case KeywordId::Outer:
        return "OUTER";
    case KeywordId::Precision:
        return "PRECISION";
    case KeywordId::Primary:
        return "PRIMARY";
    case KeywordId::Raw:
        return "RAW";
    case KeywordId::Real:
        return "REAL";
    case KeywordId::Reference:
        return "REFERENCE";
    case KeywordId::Right:
        return "RIGHT";
    case KeywordId::Rollback:
        return "ROLLBACK";
    case KeywordId::Select:
        return "SELECT";
    case KeywordId::Serial:
        return "SERIAL";
    case KeywordId::Set:
        return "SET";
    case KeywordId::Smallfloat:
        return "SMALLFLOAT";
    case KeywordId::Smallint:
        return "SMALLINT";
    case KeywordId::Some:
        return "SOME";
    case KeywordId::Sqlid:
        return "SQLID";
    case KeywordId::Sum:
        return "SUM";
    case KeywordId::Sysname:
        return "SYSNAME";
    case KeywordId::Table:
        return "TABLE";
    case KeywordId::Text:
        return "TEXT";
    case KeywordId::Time:
        return "TIME";
    case KeywordId::Timestamp:
        return "TIMESTAMP";
    case KeywordId::Timezone:
        return "TIMEZONE";
    case KeywordId::To:
        return "TO";
    case KeywordId::User:
        return "USER";
    case KeywordId::Union:
        return "UNION";
    case KeywordId::Unique:
        return "UNIQUE";
    case KeywordId::UserTypeName:
        return "USER_TYPE_NAME";
    case KeywordId::Using:
        return "USING";
    case KeywordId::Update:
        return "UPDATE";
    }
    return "UNKOWN";
}

} // namespace models::lexer::enums
