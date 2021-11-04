import Foundation

struct Weather:Decodable {
    var weather:weatherInfo
    var main:mainInfo
}

struct weatherInfo:Decodable {
    var main:String
}

struct mainInfo:Decodable {
    var temp:String
}
