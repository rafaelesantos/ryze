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

public enum RyzeIntelligencePredictionInput: Equatable {
    case tabularData([String: Any])
    case text(String)
    
    var tabularData: [String: Any] {
        switch self {
        case .tabularData(let dictionary): return dictionary
        default: return [:]
        }
    }
    
    var text: String {
        switch self {
        case .text(let text): return text
        default: return ""
        }
    }
    
    public static func == (lhs: RyzeIntelligencePredictionInput, rhs: RyzeIntelligencePredictionInput) -> Bool {
        switch (lhs, rhs) {
        case (.tabularData, .tabularData), (.text, .text): return true
        default: return false
        }
    }
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
    
    public func regressionPrediction(from input: RyzeIntelligencePredictionInput) async -> RyzeIntelligencePredictionResult {
        guard let mlModel = mlModel,
              let prediction = try? await mlModel.prediction(from: MLDictionaryFeatureProvider(dictionary: input.tabularData)),
              let value = prediction.featureValue(for: "target")?.doubleValue
        else { return .empty }
        return .tabularRegression(value)
    }
    
    public func classifierPrediction(from input: RyzeIntelligencePredictionInput) async -> RyzeIntelligencePredictionResult {
        guard let mlModel = mlModel,
              let prediction = try? await mlModel.prediction(from: MLDictionaryFeatureProvider(dictionary: input.tabularData)),
              let value = prediction.featureValue(for: "target")?.dictionaryValue as? [String: Double]
        else { return .empty }
        return .tabularClassification(value)
    }
    
    public func textPrediction(from input: RyzeIntelligencePredictionInput) async -> RyzeIntelligencePredictionResult {
        guard let mlModel = mlModel,
              let nlModel = try? NLModel(mlModel: mlModel),
              let prediction = nlModel.predictedLabel(for: input.text)
        else { return .empty }
        return .textClassification(prediction)
    }
}
