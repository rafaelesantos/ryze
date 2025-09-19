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
    
    public func regressionPrediction(from input: any MLFeatureProvider) async -> Double? {
        guard let mlModel = mlModel,
              let prediction = try? await mlModel.prediction(from: input),
              let value = prediction.featureValue(for: "target")?.doubleValue
        else { return nil }
        return value
    }
}
