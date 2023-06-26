import Vapor

let dir = NSHomeDirectory().split(separator: "/")[1]

// configures your application
public func configure(_ app: Application) async throws {
    readFile()
    kApp = app
    app.http.server.configuration.port = 1999
    let vc = CoreViewController()
    vc.configModels()
    try routes(app)
    

}

func readFile() {
    let filepath = "/Users/\(dir)/Desktop/file.txt"
    let data = try? Data(contentsOf: URL(fileURLWithPath: filepath))
    print(data)
}




