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
var md3m99: MLModel!

class CoreViewController {
    var ennf = ""
   
    
    func configModels() {
        config3m()
        config5m()
        config15m()
        config30m()
        config99m()
    }
    
    func config99m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML3mv7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m99 = model
        }
    }

    func config3m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML3mv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m = model
        }
    }
    
    func config5m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML5mv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5m = model
        }
    }
    
    func config15m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML15mv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15m = model
        }
    }
    
    func config30m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML30mv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30m = model
        }
    }
    
}
