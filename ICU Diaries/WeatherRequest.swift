//
//  WeatherRequest.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 11/2/21.
//

import Foundation

struct WeatherRequest {
    let resourceURL:URL
    let API_KEY = "b93e1ddd56msh7542897a760385cp1a1551jsn718bdf124c45"
    let host = "community-open-weather-map.p.rapidapi.com"
    
    init(city:String) {
        let resourceString = "https://community-open-weather-map.p.rapidapi.com/weather?q=\(city))&lat=0&lon=0&callback=test&id=2172797&lang=null&units=imperial"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
//    func getWeather(completion: @escaping(Result<Weather, Error>) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) {
//            data, _, _ in
//            guard let jsonData = data else {fatalError()}
//
//            do {
//                let decoder = JSONDecoder()
//                let weatherResponse = try decoder.decode(Weather.self, from: jsonData)
//            }catch{
//                completion(.failure(error))
//            }
//        }
//        dataTask.resume()
//    }
//    func getWeather() {
//        var request = URLRequest(url: resourceURL)
//           request.httpMethod = "GET"
//           request.setValue(API_KEY, forHTTPHeaderField: "x-rapidapi-key")
//           request.setValue(host, forHTTPHeaderField: "x-rapidapi-host")
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            print(response as Any)
//            print(String(data: data!, encoding: .utf8) as Any) //Try this too!
//            }.resume()
//    }
    
    func getWeather() {
        let headers = [
            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
            "x-rapidapi-key": "b93e1ddd56msh7542897a760385cp1a1551jsn718bdf124c45"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://community-open-weather-map.p.rapidapi.com/weather?q=Ann%20Arbor&units=imperial&mode=JSON")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
}
