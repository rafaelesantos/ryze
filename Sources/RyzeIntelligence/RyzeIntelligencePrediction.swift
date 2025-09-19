//
//  RyzeIntelligencePrediction.swift
//  Ryze
//
//  Created by Rafael Escaleira on 14/09/25.
//

import CoreML
import RyzeFoundation

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
    
    public func regressionPrediction(from input: [String: Any]) async -> Double? {
        guard let mlModel = mlModel,
              let prediction = try? await mlModel.prediction(from: MLDictionaryFeatureProvider(dictionary: input)),
              let value = prediction.featureValue(for: "target")?.doubleValue
        else { return nil }
        return value
    }
    
    public func classifierPrediction(from input: [String: Any]) async -> [(label: String, probability: Double)]? {
        guard let mlModel = mlModel,
              let prediction = try? await mlModel.prediction(from: MLDictionaryFeatureProvider(dictionary: input)),
              let value = prediction.featureValue(for: "target")?.dictionaryValue
        else { return nil }
        return value.compactMap {
            guard let key = $0.key as? String,
                  let value = $0.value as? Double
            else { return nil }
            return (label: key, probability: value)
        }
    }
    
    public func textPrediction(from input: String) async -> String? {
        guard let mlModel = mlModel,
              let nlModel = try? NLModel(mlModel: mlModel),
              let prediction = nlModel.predictedLabel(for: input)
        else { return nil }
        return prediction
    }
}
