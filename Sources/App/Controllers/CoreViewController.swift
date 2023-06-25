//
//  File.swift
//  
//
//  Created by xuanyuan on 2023/6/3.
//
import CoreML

var md3m: MLModel!
var md5m: MLModel!
var md15m: MLModel!
var md30m: MLModel!

var md3m101: MLModel!
var md3m103: MLModel!
var md3m105: MLModel!
var md3m10515: MLModel!
var md3m10530: MLModel!
var md5m107: MLModel!

var md30m107: MLModel!
var md15m105: MLModel!

var balance15m103: MLModel!
var balance30m101: MLModel!
var balance3m109: MLModel!
var balance5m108: MLModel!



class CoreViewController {
    var ennf = "ML3mSharpV2"
    
    func configModels() {
        config3m()
        config5m()
        config15m()
        config30m()
        config107v8()
        config105v8()
        b15m103()
        b30m101()
        b3m109()
        b5m108()
//        config101()
//        config103()
//        config105()
//        config10515()
//        config10530()
//        config107()
    }
    
    func config3m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML3mSharpV5.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m = model
        }
    }
    
    func config5m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML5mSharpV7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5m = model
        }
    }
    
    func config15m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML15mSharpV5.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15m = model
        }
    }
    
    func config30m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML30mSharpV5.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30m = model
        }
    }
    
    func config101() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML3mSharpV3.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m101 = model
        }
    }
    
    func config103() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML3mSharpV4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m103 = model
        }
    }
    
    func config105() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML3mSharpV5.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m105 = model
        }
    }
    
    func config10515() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML15mSharpV5.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m10515 = model
        }
    }
    
    func config10530() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML30mSharpV5.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m10530 = model
        }
    }
    
    func config107() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML5mSharpV7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5m107 = model
        }
    }
    
    
    func config107v8() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML30mSharpV8.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30m107 = model
        }
    }
    
    func config105v8() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML15mSharpV8.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15m105 = model
        }
    }
    
    func b15m103() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/n_ML_15m.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            balance15m103 = model
        }
    }
    
    func b30m101() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_30m.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            balance30m101 = model
        }
    }
    
    func b3m109() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_3m.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            balance3m109 = model
        }
    }
    
    func b5m108() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_5m.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            balance5m108 = model
        }
    }
    
}
