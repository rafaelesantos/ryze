//
//  RyzeTextIntelligence.swift
//  Ryze
//
//  Created by Rafael Escaleira on 13/09/25.
//

import Foundation
import RyzeFoundation
import CoreML
import TabularData

import CreateML
#if canImport(NaturalLanguage)
import NaturalLanguage
#endif

public final class RyzeTextIntelligence {
    let data: [[String: String]]
    
    public init(data: [[String : String]]) {
        self.data = data
    }
    
    public func trainingTextClassifier(id: String, name: String) async -> RyzeIntelligenceResult {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data),
              let data = try? DataFrame(jsonData: jsonData)
        else { return .error }
        
        let splits = data.randomSplit(by: 0.8)
        let trainingData = DataFrame(splits.0)
        let testingData = DataFrame(splits.1)
        let parameters = MLTextClassifier.ModelParameters(
            validation: .none,
            algorithm: .transferLearning(.bertEmbedding, revision: nil),
            language: RyzeLocale.current.naturalLanguage
        )
        
        guard let classifier = try? MLTextClassifier(
            trainingData: trainingData,
            textColumn: "text",
            labelColumn: "label",
            parameters: parameters
        ) else { return .error }
        
        let metrics = classifier.evaluation(
            on: testingData,
            textColumn: "text",
            labelColumn: "label"
        )
        
        let model = RyzeIntelligenceModel(
            id: id,
            name: name,
            createDate: Date().timeIntervalSince1970,
            updateDate: Date().timeIntervalSince1970,
            accuracy: 1 - metrics.classificationError,
            rootMeanSquaredError: metrics.classificationError
        )
        
        await save(classifier, model: model)
        return .saved(model: model)
    }

    func save(
        _ classifier: MLTextClassifier,
        model: RyzeIntelligenceModel
    ) async {
        let fileManager = RyzeFileManager()
        guard let path = await fileManager.path(
            with: "\(model.name) - \(model.id).mlmodel",
            privacy: .private
        ) else { return }
        
        do {
            try classifier.write(to: path)
            await save(on: path, for: model)
        } catch { return }
    }
    
    func save(on path: URL, for model: RyzeIntelligenceModel) async {
        var model = model
        model.path = path
        
        let defaults = RyzeDefaults()
        var models: Set<RyzeIntelligenceModel> = defaults.get(for: "ryze.models") ?? []
        if models.contains(model) { models.remove(model) }
        models.insert(model)
        
        defaults.set(models, for: "ryze.models")
    }
}
