import Vapor
import CoreML

// configures your application
public func configure(_ app: Application) async throws {
    try routes(app)
    localTest()
}

func localTest() {
    var file = #file.components(separatedBy: "App").first ?? ""
    file += "/Resources/ML.mlmodel"
    let modelUrl = URL(fileURLWithPath: file)
    let compiledUrl = try? MLModel.compileModel(at: modelUrl)
    let model = try? MLModel(contentsOf: compiledUrl!)
    let dic = [
        "redGreen" : 0,
        "current": 1.2,
        "ema": 1.23,
        "emaRate": 1.02,
        "maRate": 1.08 ,
        "pk": 1,
        "chop": 30,
        "rsi": 90,
        "so": 120,
        "cci": 400,
        "psy": 60,
    ]
    let pro = try? MLDictionaryFeatureProvider(dictionary: dic)
    
    let res = try? model?.prediction(from: pro!)
    debugPrint("res=\(res?.featureValue(for: "result"))")
}

func mlTest() {
    let modelUrl = URL(fileURLWithPath: "/Users/xuanyuan/mlDome/Sources/Resources/ML.mlmodel")
    let compiledUrl = try? MLModel.compileModel(at: modelUrl)
    let model = try? MLModel(contentsOf: compiledUrl!)
    let dic = [
        "redGreen" : 0,
        "current": 1.2,
        "ema": 1.23,
        "emaRate": 1.02,
        "maRate": 1.08 ,
        "pk": 1,
        "chop": 30,
        "rsi": 90,
        "so": 120,
        "cci": 400,
        "psy": 60,
    ]
    let pro = try? MLDictionaryFeatureProvider(dictionary: dic)
    
    let res = try? model?.prediction(from: pro!)
    debugPrint("res=\(res?.featureValue(for: "result"))")
    
}

func predictFor(dic: [String: Any]) ->Int64 {
    var file = #file.components(separatedBy: "App").first ?? ""
    file += "/Resources/ML.mlmodel"
    let modelUrl = URL(fileURLWithPath: file)
    let compiledUrl = try? MLModel.compileModel(at: modelUrl)
    let model = try? MLModel(contentsOf: compiledUrl!)
    let pro = try? MLDictionaryFeatureProvider(dictionary: dic)
    let res = try? model?.prediction(from: pro!)
    let num = res?.featureValue(for: "result") as? Int64 ?? -1
    debugPrint("res=\(num)")
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
