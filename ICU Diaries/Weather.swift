import Foundation
import SwiftUI

struct Weather:Codable {
    var weather:[weatherInfo]
    var main:mainInfo
}

struct weatherInfo:Codable {
    var main:String
}

struct mainInfo:Codable {
    var temp:Double
}


func getWeatherCondition(weather: Weather) -> String {
    return weather.weather[0].main
}

func getTemp(weather: Weather) -> Int {
    return Int(weather.main.temp)
}



class GetWeather : ObservableObject{
    
    let API_KEY = "b93e1ddd56msh7542897a760385cp1a1551jsn718bdf124c45"
    let host = "community-open-weather-map.p.rapidapi.com"
    
    func loadData(completion:@escaping (Weather) -> ()) {

        var urlBuilder = URLComponents(string: "https://community-open-weather-map.p.rapidapi.com/weather")
            urlBuilder?.queryItems = [
                URLQueryItem(name: "q", value: "Ann Arbor"),
                URLQueryItem(name: "units", value: "imperial")
                
            ]

        guard let url = urlBuilder?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(host, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(API_KEY, forHTTPHeaderField: "x-rapidapi-key")

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let response = try! JSONDecoder().decode(Weather.self, from: data!)
            guard let data = data else { return }
            let _ = print(String(data: data, encoding: .utf8)!)
            DispatchQueue.main.async {
                completion(response)
            }
        }.resume()
        
    }
    
}


struct WeatherView: View {
    @State var temp = 0
    @State var condition = ""
    
    var body: some View {
        VStack {
            Text("\(temp) degrees F and \(condition) in Ann Arbor")
                .padding()
                .onAppear() {
                    GetWeather().loadData { (weather) in
                        self.temp = getTemp(weather: weather)
                        self.condition = getWeatherCondition(weather: weather)
                    }
                }
                .frame(width: 353.15, height: 164.5)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(10.0)
                .font(.title)
                .multilineTextAlignment(.center)
                
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
