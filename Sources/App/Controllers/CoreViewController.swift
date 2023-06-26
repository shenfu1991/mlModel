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

var md3mv2: MLModel!
var md5mv2: MLModel!
var md15mv2: MLModel!
var md30mv2: MLModel!


var csvUrl: URL!

var pathName = ""
var itName = ""
var sbName = ""
var pathIdx = 0
var sbIdx = 0

let sbArr = ["BTCUSDT","ETHUSDT","TOMOUSDT","ALPHAUSDT","NKNUSDT","RSRUSDT","GRTUSDT"]
let pathArr = ["3","4","5","6"]
let itArr = ["3m","5m","15m","30m"]


class CoreViewController {
    var ennf = "ML3mSharpV2"
    
    func configModels() {
        config3m()
        config5m()
        config15m()
        config30m()
        
        config3mv2()
        config5mv2()
        config15mv2()
        config30mv2()
        
//        loopTask()
    }
    
    func loopTask() {
        
        pathName = pathArr[pathIdx]
        sbName = sbArr[sbIdx]
        itName = itArr[pathIdx]

        initFile()
        readCsvFiles()
    }
    
    func nextFile() {
        sbIdx += 1
        if sbIdx >= sbArr.count {
            sbIdx = 0
            pathIdx += 1
            if pathIdx >= pathArr.count {
                debugPrint("all finished")
                exit(0)
            }
        }
        loopTask()
    }
    
    func initFile() {
        
        let home = "/Users/xuanyuan/Documents/csv/"
//        let url = home + "\(Int.random(in: 99999...1000000000)).csv"
        let url = home + sbName + "_" + itName + "_n.csv"
        csvUrl = URL(fileURLWithPath:url)
        try? "open,high,low,rate,volume,volatility,sharp,signal,result\n".write(to: csvUrl, atomically: true, encoding: .utf8)
    }
    
    func readCsvFiles() {
        
        do {
            // 从main bundle中加载CSV文件
//            ["BTCUSDT","ETHUSDT","TOMOUSDT","ALPHAUSDT","NKNUSDT","RSRUSDT","GRTUSDT"]
            let path = "/Users/xuanyuan/Downloads/\(pathName)/\(sbName)_\(itName).csv"
//            let path = "/Users/xuanyuan/Downloads/tet.csv"
            let csvFileUrl = URL(fileURLWithPath: path)

            let csvFile = try CSV<Named>(url: csvFileUrl)
            
            // 获取所有行
            let rows = csvFile.rows
//            debugPrint("row=\(rows)")
            
//            "timestamp,current,open,high,low,rate,volume,volatility,sharp,signal\n"/
            let limit = 900
            var lc = 0
            var sc = 0
            var lnc = 0
            var snc = 0
            for (idx,_) in rows.enumerated() {
                // 使用列名来访问数据
                
//                debugPrint("t=\(timestamp),open=\(open)")
                
                if idx >= limit {
                    let arr = rows[idx-20...idx]
                    let firstRow = rows[idx-(limit-1)]
                    
//                    let ftimestamp = firstRow["timestamp"]?.doubleValue()
                    let fcurrent = firstRow["current"]?.doubleValue() ?? 0
                    let fopen = firstRow["open"]?.doubleValue() ?? 0
                    let fhigh = firstRow["high"]?.doubleValue() ?? 0
                    let flow = firstRow["low"]?.doubleValue() ?? 0
                    let frate = firstRow["rate"]?.doubleValue() ?? 0
                    let fvolume = firstRow["volume"]?.doubleValue() ?? 0
                    let fvolatility = firstRow["volatility"]?.doubleValue() ?? 0
                    let fsharp = firstRow["sharp"]?.doubleValue() ?? 0
                    let fsignal = firstRow["signal"]?.doubleValue() ?? 0
                    
                    let foreCurrents = arr.map { dic in
                        (dic["current"] ?? "").doubleValue()
                    }
                    
                    let tag = getTag(current:fcurrent, values: foreCurrents)
                    
//                    open,high,low,rate,volume,volatility,sharp,signal,result\n
                    let newRow = "\(fopen.fmt()),\(fhigh.fmt()),\(flow.fmt()),\(frate.fmt()),\(fvolume.fmt()),\(fvolatility.fmt()),\(fsharp.fmt()),\(fsignal.fmt()),\(tag)\n"
                    
                    addContent(text: newRow)
                    if tag == "long" {
                        lc += 1
                    }else if tag == "short" {
                        sc += 1
                    }else if tag == "LN" {
                        lnc += 1
                    }else if tag == "SN" {
                        snc += 1
                    }
                }
            }
            debugPrint("finished")
            debugPrint("\(lc),\(lnc),\(sc),\(snc)")
            debugPrint("next file...")
            nextFile()
//            exit(0)
        } catch let error {
            print("Error reading CSV file: \(error)")
        }
    }
    
    func addContent(text: String) {
        do {
            let fileHandle = try FileHandle(forWritingTo: csvUrl)
            
            // 将文件指针移动到文件末尾
            fileHandle.seekToEndOfFile()
            
            if let data = text.data(using: .utf8) {
                fileHandle.write(data)
            }
            
            fileHandle.closeFile()
        }catch {
            
        }
    }
    
    func getTag(current: Double,values: [Double]) ->String {
        
        //long,LN,short,SN,none
        var currentEarnRate: Double = 0
        var lc = 0
        var sc = 0
        var lnc = 0
        var snc = 0
        for v in values {
            currentEarnRate = (v - current)/current
            if currentEarnRate >= 0.0125 {
                lc += 1
            }else if currentEarnRate > 0 {
                lnc += 1
            } else if -currentEarnRate > 0.0125 {
                sc += 1
            }else if -currentEarnRate > 0 {
                snc += 1
            }else{
//                nonec += 1
            }
        }
        
        let maxV = [lc,sc,lnc,snc].max() ?? 0
        
        if maxV == lc {
            return "long"
        }else if maxV == sc {
            return "short"
        }else if maxV == lnc {
            return "LN"
        }else if maxV == snc {
            return "SN"
        }
        
        return "none"
    }

    
    func config3m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_3m.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3m = model
        }
    }
    
    func config5m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_5m.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5m = model
        }
    }
    
    func config15m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_15m.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15m = model
        }
    }
    
    func config30m() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_30m.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30m = model
        }
    }
    
    func config3mv2() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_3mV2.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md3mv2 = model
        }
    }
    
    func config5mv2() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_5mV2.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md5mv2 = model
        }
    }
    
    func config15mv2() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_15mV2.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md15mv2 = model
        }
    }
    
    func config30mv2() {
        var file = #file.components(separatedBy: "App").first ?? ""
        file += "/Resources/ML_30mV2.mlmodel"
        let modelUrl = URL(fileURLWithPath: file)
        if let compiledUrl = try? MLModel.compileModel(at: modelUrl) {
            let model = try? MLModel(contentsOf: compiledUrl)
            md30mv2 = model
        }
    }

    
    
}
