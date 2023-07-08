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

var md3ma1: MLModel!
var md5ma1: MLModel!
var md15ma1: MLModel!
var md30ma1: MLModel!
var md1ha1: MLModel!
var md4ha1: MLModel!


var csvUrl: URL!

var pathName = ""
var itName = ""
var sbName = ""
var pathIdx = 0
var sbIdx = 0


class CoreViewController {
    var ennf = "ML3mSharpa1"
    
    func configModels() {
        config3m()
        config5m()
        config15m()
        config30m()
        config1h()
        config4h()

        config3ma1()
        config5ma1()
        config15ma1()
        config30ma1()
        config1ha1()
        config4ha1()
    }
 
    func config3m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/3mv7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m = model
        }
    }
    
    func config5m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/5mv7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5m = model
        }
    }
    
    func config15m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/15mv7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15m = model
        }
    }
    
    func config30m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/30mv7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30m = model
        }
    }
    
    func config1h() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/1hv7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md1h = model
        }
    }
    
    func config4h() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/4hv7.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md4h = model
        }
    }
    
    func config3ma1() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/3v4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3ma1 = model
        }
    }
    
    func config5ma1() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/5v4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5ma1 = model
        }
    }
    
    func config15ma1() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/15v4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15ma1 = model
        }
    }
    
    func config30ma1() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/30v4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30ma1 = model
        }
    }
    
    func config1ha1() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/1v4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md1ha1 = model
        }
    }
    
    func config4ha1() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/4v4.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md4ha1 = model
        }
    }
    
    
}
