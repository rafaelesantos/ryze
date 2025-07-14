import os

enum RyzeFoundationLogMessage: RyzeResourceLogMessage {
    case message(String)
    case error(Error)

    var value: String {
        switch self {
        case let .message(string): return string
        case let .error(error): return error.localizedDescription
        }
    }
}
