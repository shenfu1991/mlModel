import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
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
//            if interval.contains("99") {
//                debugPrint("99=\(js)")
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
    
    app.get("sendCSV",":symbol",":interval",":csvString",":earn") { req -> AddMLModel in
        csvKey.withLock {
            let symbol = req.parameters.get("symbol") ?? ""
            let interval = req.parameters.get("interval") ?? ""
            let csvStr = req.parameters.get("csvString") ?? ""
            let earn = req.parameters.get("earn") ?? ""
            csvString += csvStr
            debugPrint("e=\(earn),csv=\(csvString)")
            write2Desktop(text: csvString)
            
            if interval == "3m" {
                csvString3m += csvStr
                write2DesktopMins(text: csvString3m, interval: "3m")
            }else if interval == "5m" {
                csvString5m += csvStr
                write2DesktopMins(text: csvString5m, interval: "5m")
            }else if interval == "15m" {
                csvString15m += csvStr
                write2DesktopMins(text: csvString15m, interval: "15m")
            }else if interval == "30m" {
                csvString30m += csvStr
                write2DesktopMins(text: csvString30m, interval: "30m")
            }
            
            return AddMLModel(msg: "success", success: true,result: "res")
        }
    }
    
    func fileNameT() ->String {
        let format = DateFormatter()
        format.dateFormat = "MM-dd^HH:mm"
        return format.string(from: Date())
    }
    
    func write2Desktop(text: String) {
        var fileURL = URL(string: "")
        let name =  "csv_" + fileNameT()
        if #available(macOS 13.0, *) {
            fileURL = URL(filePath:"/Users/\(dir)/Desktop/csv_data/\(name).csv")
        } else {
            // Fallback on earlier versions
        }
        
        do {
            try text.write(to: fileURL!, atomically: true, encoding: .utf8)
        } catch {
            print("Unable to write file")
        }
                
    }
    
    func write2DesktopMins(text: String,interval:String) {
        var fileURL = URL(string: "")
        let name =  "csv_" + fileNameT()
        if #available(macOS 13.0, *) {
            fileURL = URL(filePath:"/Users/\(dir)/Desktop/csv_data/\(interval)/\(name).csv")
        } else {
            // Fallback on earlier versions
        }
        
        do {
            try text.write(to: fileURL!, atomically: true, encoding: .utf8)
        } catch {
            print("Unable to write file")
        }
                
    }

    
    
}


