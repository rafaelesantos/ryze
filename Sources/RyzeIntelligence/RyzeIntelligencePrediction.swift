//
//  RyzeIntelligencePrediction.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/09/25.
//

import CoreML
import RyzeFoundation

public enum RyzeIntelligencePredictionResult {
    case textClassification(String)
    case tabularRegression(Double)
    case tabularClassification([String: Double])
    case empty
}

public final class RyzeIntelligencePrediction {
    let model: RyzeIntelligenceModel
    var mlModel: MLModel?
    
    public init(model: RyzeIntelligenceModel) async {
        self.model = model
        await setup()
    }
    
    func setup() async {
        guard let url = model.path,
              let compileModel = try? await MLModel.compileModel(at: url),
              let mlModel = try? MLModel(contentsOf: compileModel)
        else { return }
        self.mlModel = mlModel
    }
    
    public func regressionPrediction(from input: [String: Any]) async -> RyzeIntelligencePredictionResult {
        guard let mlModel = mlModel,
              let prediction = try? await mlModel.prediction(from: MLDictionaryFeatureProvider(dictionary: input)),
              let value = prediction.featureValue(for: "target")?.doubleValue
        else { return .empty }
        return .tabularRegression(value)
    }
    
    public func classifierPrediction(from input: [String: Any]) async -> RyzeIntelligencePredictionResult {
        guard let mlModel = mlModel,
              let prediction = try? await mlModel.prediction(from: MLDictionaryFeatureProvider(dictionary: input)),
              let value = prediction.featureValue(for: "target")?.dictionaryValue as? [String: Double]
        else { return .empty }
        return .tabularClassification(value)
    }
    
    public func textPrediction(from input: String) async -> RyzeIntelligencePredictionResult {
        guard let mlModel = mlModel,
              let nlModel = try? NLModel(mlModel: mlModel),
              let prediction = nlModel.predictedLabel(for: input)
        else { return .empty }
        return .textClassification(prediction)
    }
}
