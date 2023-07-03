//
//  File.swift
//  
//
//  Created by xuanyuan on 2023/6/3.
//
import CoreML
import SwiftCSV

var md3m: MLModel!
var md5m: MLModel!
var md15m: MLModel!
var md30m: MLModel!
var md1h: MLModel!
var md4h: MLModel!

var md3mv4: MLModel!
var md5mv4: MLModel!
var md15mv4: MLModel!
var md30mv4: MLModel!
var md1hv4: MLModel!
var md4hv4: MLModel!


var csvUrl: URL!

var pathName = ""
var itName = ""
var sbName = ""
var pathIdx = 0
var sbIdx = 0

class CoreViewController {
    var ennf = "ML3mSharpv4"
    
    func configModels() {
        config3m()
        config5m()
        config15m()
        config30m()
        config1h()
        config4h()

        config3mv4()
        config5mv4()
        config15mv4()
        config30mv4()
        config1hv4()
        config4hv4()
    }
 
    func config3m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/3mv3.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m = model
        }
    }
    
    func config5m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/5mv3.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5m = model
        }
    }
    
    func config15m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/15mv3.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15m = model
        }
    }
    
    func config30m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/30mv3.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30m = model
        }
    }
    
    func config1h() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/1hv3.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md1h = model
        }
    }
    
    func config4h() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/4hv3.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md4h = model
        }
    }
    
    func config3mv4() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/3mv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3mv4 = model
        }
    }
    
    func config5mv4() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/5mv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5mv4 = model
        }
    }
    
    func config15mv4() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/15mv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15mv4 = model
        }
    }
    
    func config30mv4() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/30mv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30mv4 = model
        }
    }
    
    func config1hv4() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/1hv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md1hv4 = model
        }
    }
    
    func config4hv4() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/4hv4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md4hv4 = model
        }
    }
    
    
}
