//
//  RyzeUIError.swift
//  Ryze
//
//  Created by Rafael Escaleira on 06/06/25.
//

@_exported import RyzeFoundation

public enum RyzeUIError: RyzeError {
    
    case systemSymbolNotFound
    
    public var description: String {
        switch self {
        case .systemSymbolNotFound:
            return "❌ SF Symbol not found in the system."
        }
    }
    
    public var errorDescription: String? {
        switch self {
        case .systemSymbolNotFound:
            return "❗️The requested SF Symbol could not be located."
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .systemSymbolNotFound:
            return "🔍 The system does not contain the specified SF Symbol."
        }
    }
    
    public var recoverySuggestion: String? {
        switch self {
        case .systemSymbolNotFound:
            return "💡 Check if the SF Symbol name is correct and available on this iOS version."
        }
    }
    
}
