//
//  InspoQuotes.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 11/3/21.
//

import Foundation


struct ResponseData: Codable {
    var quotes: [Quote]
}
struct Quote : Codable, Identifiable {
    let id = UUID()
    var quote: String
    var author: String
}

class Api : ObservableObject{
    @Published var quotes = [Quote]()
    
    func loadData(completion:@escaping ([Quote]) -> ()) {
        guard let url = URL(string: "https://gist.githubusercontent.com/nasrulhazim/54b659e43b1035215cd0ba1d4577ee80/raw/e3c6895ce42069f0ee7e991229064f167fe8ccdc/quotes.json") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            print(data as Any)
            let response = try! JSONDecoder().decode(ResponseData.self, from: data!)
            print(response)
            DispatchQueue.main.async {
                completion(response.quotes)
            }
        }.resume()
        
    }
}
