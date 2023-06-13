//
//  File.swift
//  
//
//  Created by xuanyuan on 2023/6/3.
//

import Vapor
import CoreML

extension Double {
    func str2XF(num: Int) ->String{
        return String(format: "%.\(num)f", self)
    }
    func str2F() ->String{
        if fabs(self) < 0.01 {
            return String(format: "%.6f", self)
        }
        return String(format: "%.2f", self)
    }
}

extension CoreViewController {
    
    func string2T(day: String) ->TimeInterval {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        format.timeZone = TimeZone.init(identifier: TimeZone.current.identifier)
        return format.date(from: day)?.timeIntervalSince1970 ?? 0
    }
    
}



func predictFor(dic: [String: Any]) ->Int {
    
    var file = #file.components(separatedBy: "App").first ?? ""
    file += "/Resources/ML.mlmodel"
    let modelUrl = URL(fileURLWithPath: file)
    let compiledUrl = try? MLModel.compileModel(at: modelUrl)
    let model = try? MLModel(contentsOf: compiledUrl!)
//    debugPrint(model)
    let pro = try? MLDictionaryFeatureProvider(dictionary: dic)
    let res = try? model?.prediction(from: pro!)
    if let num = res?.featureValue(for: "result") {
//        debugPrint("res=\(res),\(num)")
        let str = "\(num)"
        let number = str.getDigial()
        debugPrint("num=\(number)")
        return number
    }
    return -1
}

func predictFor3(dic: [String: Any]) ->Int {
    
    var file = #file.components(separatedBy: "App").first ?? ""
    file += "/Resources/ML3.mlmodel"
    let modelUrl = URL(fileURLWithPath: file)
    let compiledUrl = try? MLModel.compileModel(at: modelUrl)
    let model = try? MLModel(contentsOf: compiledUrl!)
//    debugPrint(model)
    let pro = try? MLDictionaryFeatureProvider(dictionary: dic)
    let res = try? model?.prediction(from: pro!)
    if let num = res?.featureValue(for: "result") {
//        debugPrint("res=\(res),\(num)")
        let str = "\(num)"
        let number = str.getDigial()
        debugPrint("num=\(number)")
        return number
    }
    return -1
}

func string2Json(text: String) -> [String:Any] {
    let data = Data(text.utf8)
    do {
        // make sure this JSON is in the format we expect
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
           return json
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
    return [:]
}

func json2String(json: [String: Any]) ->String {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        let jsonString = String(data: jsonData, encoding: .utf8)
        return jsonString ?? ""
//        print(jsonString!)
        // Output: {"city":"New York","name":"John","age":30}
    } catch {
        print(error.localizedDescription)
    }
    return ""
}

func handleData(data: Any?) ->Double {
    
    if let da = data as? String {
        return Double(da) ?? 0
    }else if let da = data as? Double {
        return da
    }
    
    return 0
}

func getTime() ->String {
    let format = DateFormatter()
    format.dateFormat = "HH:mm:ss"
    return format.string(from: Date())
}

func predictForv4(dic: [String: Any],interval: String,symbol: String) ->String {
    
    var dict: [String: Any] = [:]
    let open = handleData(data: dic["open"])
    let high = handleData(data: dic["high"])
    let low = handleData(data: dic["low"])
    let volume = handleData(data: dic["volume"])
    let volatility = handleData(data: dic["volatility"])
    
    dict = [
        "open": open,
        "high": high,
        "low": low,
        "volume": volume,
        "volatility": volatility,
    ]
    
    var file = #file.components(separatedBy: "App").first ?? ""
//    if interval.contains("99") {
        file += "/Resources/ML3mv8.mlmodel"
//        debugPrint("99=\(dic),d=\(dict)")
//    }else{
//        file += "/Resources/ML\(interval)v4.mlmodel"
//    }
    let modelUrl = URL(fileURLWithPath: file)
    let compiledUrl = try? MLModel.compileModel(at: modelUrl)
    let model = try? MLModel(contentsOf: compiledUrl!)
    let pro = try? MLDictionaryFeatureProvider(dictionary: dict)
    if let res = try? model?.prediction(from: pro!) {
        if let num = res.featureValue(for: "result") {
            let str = (num).stringValue
            debugPrint("num=\(str)-\(symbol)-\(interval) \(getTime())")
            return str
        }
    }else{
        debugPrint("模型加载失败: \(dic)")
    }
    return ""
}

extension String {
    func extractNumbersFromString() -> String {
        let regex = try! NSRegularExpression(pattern: "\\d+")
        let matches = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
        let numbers = matches.map { String(self[Range($0.range, in: self)!]) }
        return numbers.joined()
    }
    
    func getDigial() ->Int {
        return Int(extractNumbersFromString()) ?? -1
    }
}
