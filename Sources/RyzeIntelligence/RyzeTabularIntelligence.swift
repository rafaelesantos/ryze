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

#if targetEnvironment(simulator)
#else
import CreateML
#endif
#if canImport(NaturalLanguage)
import NaturalLanguage
#endif

public final class RyzeTabularIntelligence {
    var data: [[String: Any]]
    
    public init(data: [[String : Any]]) {
        self.data = data
    }
    
    public func trainingRegressor(id: String, name: String) async -> RyzeIntelligenceResult {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data),
              let data = try? DataFrame(jsonData: jsonData)
        else { return .error }
        
        let splits = data.randomSplit(by: 0.8)
        let trainingData = DataFrame(splits.0)
        let testingData = DataFrame(splits.1)
        
        #if targetEnvironment(simulator)
        return .error
        #else
        let parameters = MLBoostedTreeRegressor.ModelParameters(
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
            targetColumn: String(describing: "target"),
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
        #endif
    }
    
    public func trainingClassifier(id: String, name: String) async -> RyzeIntelligenceResult {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data),
              let data = try? DataFrame(jsonData: jsonData)
        else { return .error }
        
        let splits = data.randomSplit(by: 0.8)
        let trainingData = DataFrame(splits.0)
        let testingData = DataFrame(splits.1)
        
        #if targetEnvironment(simulator)
        return .error
        #else
        let parameters = MLBoostedTreeClassifier.ModelParameters(
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
            targetColumn: "target",
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
        #endif
    }
    
    #if targetEnvironment(simulator)
    #else
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
        _ regressor: MLBoostedTreeClassifier,
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
    #endif
    
    func save(
        on path: URL,
        for model: RyzeIntelligenceModel
    ) async {
        var model = model
        model.path = path
        
        let defaults = RyzeDefaults()
        var models: Set<RyzeIntelligenceModel> = defaults.get(for: "ryze.models") ?? []
        if models.contains(model) { models.remove(model) }
        models.insert(model)
        
        defaults.set(models, for: "ryze.models")
    }
}
