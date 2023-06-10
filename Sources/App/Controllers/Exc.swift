//
//  File.swift
//  
//
//  Created by xuanyuan on 2023/6/3.
//

import Vapor
import CoreML

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

func predictForv4(dic: [String: Any],interval: String,symbol: String) ->String {
    
    let open = dic["open"] as? Double ?? 0
    let high = dic["high"] as? Double ?? 0
    let low = dic["low"] as? Double ?? 0
    let volume = dic["volume"] as? Double ?? 0
    let volatility = dic["volatility"] as? Double ?? 0
    
    let dict = [
        "open": open,
        "high": high,
        "low": low,
        "volume": volume,
        "volatility": volatility,
    ]
    
    var file = #file.components(separatedBy: "App").first ?? ""
    file += "/Resources/ML\(interval)v4.mlmodel"
//    file += "/Resources/ML3mv4.mlmodel"
    let modelUrl = URL(fileURLWithPath: file)
    let compiledUrl = try? MLModel.compileModel(at: modelUrl)
    let model = try? MLModel(contentsOf: compiledUrl!)
//    debugPrint(model)
    let pro = try? MLDictionaryFeatureProvider(dictionary: dict)
    if let res = try? model?.prediction(from: pro!) {
        if let num = res.featureValue(for: "result") {
            //        debugPrint("res=\(res),\(num)")
            let str = (num).stringValue
            //        let number = str.getDigial()
            debugPrint("num=\(str)-\(symbol)-\(interval)")
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
