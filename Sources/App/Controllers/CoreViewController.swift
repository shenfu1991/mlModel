//
//  File.swift
//  
//
//  Created by xuanyuan on 2023/6/3.
//
import CoreML

var md3m: MLModel!
var md3m101: MLModel!
var md3m103: MLModel!

class CoreViewController {
    var ennf = "ML3mSharpV2"
    
    func configModels() {
        config3m()
        config101()
        config103()
    }
    
    func config3m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML3mSharpV2.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m = model
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
    

    
}
