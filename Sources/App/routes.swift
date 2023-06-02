import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("ml",":v") { req -> AddUserModel in
        let v = req.parameters.get("v") ?? ""
        let data = Data(base64Encoded: v) ?? Data()
        let decryptedString = String(data: data, encoding: .utf8) ?? ""
        print(decryptedString)
        let js = string2Json(text: decryptedString)
        
//        let originalString = "Hello, World!"
        if let data1 = decryptedString.data(using: .utf8) {
            let base64String = data1.base64EncodedString()
            print(base64String)
        }
        
        
        let num = predictFor(dic: js)
        return AddUserModel(msg: "success", success: true,num: num)
    }

    
}


