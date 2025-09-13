#pragma once

#include <string>

namespace models::lexer::enums {

enum class IdentifierId {
    AuthorizationId,
    LocationId,
    ColumnName,
    TableName,
    ViewName,
    StatementName,
    RangeVariable,
    ProcedureName
};

inline std::string toString(IdentifierId id) {
    switch (id) {
    case IdentifierId::AuthorizationId:
        return "AUTHORIZATION_ID";
    case IdentifierId::LocationId:
        return "LOCATION_ID";
    case IdentifierId::ColumnName:
        return "COLUMN_NAME";
    case IdentifierId::TableName:
        return "TABLE_NAME";
    case IdentifierId::ViewName:
        return "VIEW_NAME";
    case IdentifierId::StatementName:
        return "STATEMENT_NAME";
    case IdentifierId::RangeVariable:
        return "RANGE_VARIABLE";
    case IdentifierId::ProcedureName:
        return "PROCEDURE_NAME";
    }
    return "<unknown>";
}

} // namespace models::lexer::enums
