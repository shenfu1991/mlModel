import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("ml",":v") { req -> AddUserModel in
        DispatchQueue.global().sync {
            let v = req.parameters.get("v") ?? ""
            let data = Data(base64Encoded: v) ?? Data()
            let decryptedString = String(data: data, encoding: .utf8) ?? ""
            print(decryptedString)
            let js = string2Json(text: decryptedString)
            let num = predictFor(dic: js)
            return AddUserModel(msg: "success", success: true,num: num)
        }
    }

    app.get("ml3",":v") { req -> AddUserModel in
        DispatchQueue.global().sync {
            let v = req.parameters.get("v") ?? ""
            let data = Data(base64Encoded: v) ?? Data()
            let decryptedString = String(data: data, encoding: .utf8) ?? ""
            print(decryptedString)
            let js = string2Json(text: decryptedString)
            let num = predictFor3(dic: js)
            return AddUserModel(msg: "success", success: true,num: num)
        }
    }
    
    app.get("setJsonInfo",":symbol",":interval",":json") { req -> AddMLModel in
        mlKey.withLock {
            let symbol = req.parameters.get("symbol") ?? ""
            let interval = req.parameters.get("interval") ?? ""
            let v = req.parameters.get("json") ?? ""
            let data = Data(base64Encoded: v) ?? Data()
            let decryptedString = String(data: data, encoding: .utf8) ?? ""
            let js = string2Json(text: decryptedString)
            let name = "\(symbol)_\(interval)"
//            if interval == "3m" {
//                interval = "5m"
//            }
            let res = predictForv4(dic: js, interval: interval,symbol: symbol)
            MLInfo[name] = res
            return AddMLModel(msg: "success", success: true,result: res)
        }
    }
    
    
    app.get("getMLResult",":symbol",":interval") { req -> AddMLModel in
        mlKey.withLock {
            let symbol = req.parameters.get("symbol") ?? ""
            let interval = req.parameters.get("interval") ?? ""
            let name = "\(symbol)_\(interval)"
            let res = MLInfo[name]
            return AddMLModel(msg: "success", success: true,result: res)
        }
    }
    
    
}


