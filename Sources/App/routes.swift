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
    
}


