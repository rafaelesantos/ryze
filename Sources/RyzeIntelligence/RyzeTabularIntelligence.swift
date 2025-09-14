//
//  RyzeTabularIntelligence.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/09/25.
//

import Foundation
import RyzeFoundation
import CoreML
import TabularData

#if canImport(CreateML)
import CreateML
#endif
#if canImport(NaturalLanguage)
import NaturalLanguage
#endif

public actor RyzeTabularIntelligence<T> {
    var values: [T]
    var features: [KeyPath<T, Any>]
    var target: KeyPath<T, Any>
    
    public init(
        values: [T],
        features: [KeyPath<T, Any>],
        target: KeyPath<T, Any>
    ) {
        self.values = values
        self.features = features
        self.target = target
    }
    
    func generateData() -> Data? {
        var trainingData: [[String: Any]] = []
        for value in values {
            var data: [String: Any] = [:]
            for item in features {
                let key = String(describing: item)
                data[key] = value[keyPath: item]
            }
            data["targe"] = value[keyPath: target]
            trainingData.append(data)
        }
        return try? JSONSerialization.data(withJSONObject: trainingData)
    }
    
    public func trainingRegressor(id: String, name: String) async -> RyzeIntelligenceResult {
        guard let jsonData = generateData(),
              let data = try? DataFrame(jsonData: jsonData)
        else { return .error }
        
        let splits = data.randomSplit(by: 0.8)
        let trainingData = DataFrame(splits.0)
        let testingData = DataFrame(splits.1)
        
        var parameters = MLBoostedTreeRegressor.ModelParameters(
            validation: .dataFrame(testingData),
            maxDepth: 20,
            maxIterations: 10_000,
            minLossReduction: .zero,
            minChildWeight: 0.01,
            randomSeed: 42,
            stepSize: 0.01,
            earlyStoppingRounds: nil,
            rowSubsample: 1,
            columnSubsample: 1
        )
        
        guard let regressor = try? MLBoostedTreeRegressor(
            trainingData: trainingData,
            targetColumn: String(describing: target),
            parameters: parameters
        ) else { return .error }
        
        let metrics = regressor.evaluation(on: testingData)
        let model = RyzeIntelligenceModel(
            id: id,
            name: name,
            createDate: Date().timeIntervalSince1970,
            updateDate: Date().timeIntervalSince1970,
            accuracy: 1 - metrics.rootMeanSquaredError,
            rootMeanSquaredError: metrics.rootMeanSquaredError
        )
        await save(regressor, model: model)
        return .saved(model: model)
    }
    
    public func trainingClassifier(id: String, name: String) async -> RyzeIntelligenceResult {
        guard let jsonData = generateData(),
              let data = try? DataFrame(jsonData: jsonData)
        else { return .error }
        
        let splits = data.randomSplit(by: 0.8)
        let trainingData = DataFrame(splits.0)
        let testingData = DataFrame(splits.1)
        
        var parameters = MLBoostedTreeClassifier.ModelParameters(
            validation: .dataFrame(testingData),
            maxDepth: 20,
            maxIterations: 10_000,
            minLossReduction: .zero,
            minChildWeight: 0.01,
            randomSeed: 42,
            stepSize: 0.01,
            earlyStoppingRounds: nil,
            rowSubsample: 1,
            columnSubsample: 1
        )
        
        guard let regressor = try? MLBoostedTreeClassifier(
            trainingData: trainingData,
            targetColumn: String(describing: target),
            parameters: parameters
        ) else { return .error }
        
        let metrics = regressor.evaluation(on: testingData)
        let model = RyzeIntelligenceModel(
            id: id,
            name: name,
            createDate: Date().timeIntervalSince1970,
            updateDate: Date().timeIntervalSince1970,
            accuracy: 1 - metrics.classificationError,
            rootMeanSquaredError: metrics.classificationError
        )
        
        await save(regressor, model: model)
        return .saved(model: model)
    }
    
    func save(
        _ regressor: MLBoostedTreeRegressor,
        model: RyzeIntelligenceModel
    ) async {
        let fileManager = RyzeFileManager()
        guard let path = await fileManager.path(
            with: "\(model.name) - \(model.id).mlmodel",
            privacy: .private
        ) else { return }
        
        do {
            try regressor.write(to: path)
            await save(on: path, for: model)
        } catch { return }
    }
    
    func save(
        on path: URL,
        for model: RyzeIntelligenceModel
    ) async {
        var model = model
        model.path = path
        
        let defaults = RyzeDefaults()
        var models: [RyzeIntelligenceModel] = await defaults.get(for: "ryze.models") ?? []
        models.append(model)
        
        await defaults.set(models, for: "ryze.models")
    }
}
