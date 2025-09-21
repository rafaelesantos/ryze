//
//  RyzeIntelligenceModel.swift
//  Ryze
//
//  Created by Rafael Escaleira on 13/09/25.
//

import Foundation
import RyzeFoundation

public struct RyzeIntelligenceModel: RyzeEntity, Sendable {
    public var id: String
    public var name: String
    public var isTraining: Bool
    public var createDate: TimeInterval?
    public var updateDate: TimeInterval?
    public var accuracy: Double?
    public var rootMeanSquaredError: Double?
    public var path: URL?
    
    public init(
        id: String,
        name: String,
        isTraining: Bool = false,
        createDate: TimeInterval? = nil,
        updateDate: TimeInterval? = nil,
        accuracy: Double? = nil,
        rootMeanSquaredError: Double? = nil,
        path: URL? = nil
    ) {
        self.id = id
        self.name = name
        self.isTraining = isTraining
        self.createDate = createDate
        self.updateDate = updateDate
        self.accuracy = accuracy
        self.rootMeanSquaredError = rootMeanSquaredError
        self.path = path
    }
}
