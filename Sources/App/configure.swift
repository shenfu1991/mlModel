import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    try routes(app)
//    localTest()
    
   
    
//    mlTest()
    
//    localTest()
    
//    gogo()
    
}

func gogo() {
    
    let dic = [
        "redGreen" : "red",
        "current": 1.678,
        "ema": 1.63,
        "emaRate": 1.03,
        "maRate": 1.03 ,
        "pk": 1.0,
        "chop": 34.59,
        "rsi": 71.12,
        "so": 55.56,
        "cci": 74.44,
        "psy": 50.0,
    ] as [String : Any]
    
    
//    let dic = [
//        "redGreen" : "red",
//        "current": 1.621,
//        "ema": 1.61,
//        "emaRate": 1.01,
//        "maRate": 1.01 ,
//        "pk": 1,
//        "chop": 37.74,
//        "rsi": 59.17,
//        "so": 94.74,
//        "cci": 70.08,
//        "psy": 65,
//    ] as [String : Any]
    predictFor(dic: dic)
    
    
}




