//
// ML.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class MLInput : MLFeatureProvider {

    /// redGreen as double value
    var redGreen: Double

    /// current as double value
    var current: Double

    /// ema as double value
    var ema: Double

    /// emaRate as double value
    var emaRate: Double

    /// maRate as double value
    var maRate: Double

    /// pk as double value
    var pk: Double

    /// chop as double value
    var chop: Double

    /// rsi as double value
    var rsi: Double

    /// so as double value
    var so: Double

    /// cci as double value
    var cci: Double

    /// psy as double value
    var psy: Double

    var featureNames: Set<String> {
        get {
            return ["redGreen", "current", "ema", "emaRate", "maRate", "pk", "chop", "rsi", "so", "cci", "psy"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "redGreen") {
            return MLFeatureValue(double: redGreen)
        }
        if (featureName == "current") {
            return MLFeatureValue(double: current)
        }
        if (featureName == "ema") {
            return MLFeatureValue(double: ema)
        }
        if (featureName == "emaRate") {
            return MLFeatureValue(double: emaRate)
        }
        if (featureName == "maRate") {
            return MLFeatureValue(double: maRate)
        }
        if (featureName == "pk") {
            return MLFeatureValue(double: pk)
        }
        if (featureName == "chop") {
            return MLFeatureValue(double: chop)
        }
        if (featureName == "rsi") {
            return MLFeatureValue(double: rsi)
        }
        if (featureName == "so") {
            return MLFeatureValue(double: so)
        }
        if (featureName == "cci") {
            return MLFeatureValue(double: cci)
        }
        if (featureName == "psy") {
            return MLFeatureValue(double: psy)
        }
        return nil
    }
    
    init(redGreen: Double, current: Double, ema: Double, emaRate: Double, maRate: Double, pk: Double, chop: Double, rsi: Double, so: Double, cci: Double, psy: Double) {
        self.redGreen = redGreen
        self.current = current
        self.ema = ema
        self.emaRate = emaRate
        self.maRate = maRate
        self.pk = pk
        self.chop = chop
        self.rsi = rsi
        self.so = so
        self.cci = cci
        self.psy = psy
    }

}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class MLOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// result as integer value
    var result: Int64 {
        return self.provider.featureValue(for: "result")!.int64Value
    }

    /// resultProbability as dictionary of 64-bit integers to doubles
    var resultProbability: [Int64 : Double] {
        return self.provider.featureValue(for: "resultProbability")!.dictionaryValue as! [Int64 : Double]
    }

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(result: Int64, resultProbability: [Int64 : Double]) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["result" : MLFeatureValue(int64: result), "resultProbability" : MLFeatureValue(dictionary: resultProbability as [AnyHashable : NSNumber])])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class ML {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "ML", withExtension:"mlmodelc")!
    }

    /**
        Construct ML instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of ML.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `ML.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct ML instance by automatically loading the model from the app's bundle.
    */
    @available(*, deprecated, message: "Use init(configuration:) instead and handle errors appropriately.")
    convenience init() {
        try! self.init(contentsOf: type(of:self).urlOfModelInThisBundle)
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(configuration: MLModelConfiguration) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct ML instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct ML instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<ML, Error>) -> Void) {
        return self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct ML instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> ML {
        return try await self.load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct ML instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    @available(macOS 11.0, iOS 14.0, tvOS 14.0, watchOS 7.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<ML, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(ML(model: model)))
            }
        }
    }

    /**
        Construct ML instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> ML {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return ML(model: model)
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as MLInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as MLOutput
    */
    func prediction(input: MLInput) throws -> MLOutput {
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        - parameters:
           - input: the input to the prediction as MLInput
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as MLOutput
    */
    func prediction(input: MLInput, options: MLPredictionOptions) throws -> MLOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return MLOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        - parameters:
            - redGreen as double value
            - current as double value
            - ema as double value
            - emaRate as double value
            - maRate as double value
            - pk as double value
            - chop as double value
            - rsi as double value
            - so as double value
            - cci as double value
            - psy as double value

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as MLOutput
    */
    func prediction(redGreen: Double, current: Double, ema: Double, emaRate: Double, maRate: Double, pk: Double, chop: Double, rsi: Double, so: Double, cci: Double, psy: Double) throws -> MLOutput {
        let input_ = MLInput(redGreen: redGreen, current: current, ema: ema, emaRate: emaRate, maRate: maRate, pk: pk, chop: chop, rsi: rsi, so: so, cci: cci, psy: psy)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        - parameters:
           - inputs: the inputs to the prediction as [MLInput]
           - options: prediction options 

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [MLOutput]
    */
    @available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *)
    func predictions(inputs: [MLInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [MLOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [MLOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  MLOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
