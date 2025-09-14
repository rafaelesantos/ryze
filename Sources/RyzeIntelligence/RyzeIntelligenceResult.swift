//
//  RyzeIntelligenceResult.swift
//  Ryze
//
//  Created by Rafael Escaleira on 13/09/25.
//

public enum RyzeIntelligenceResult: Sendable {
    case error
    case saved(model: RyzeIntelligenceModel)
}
