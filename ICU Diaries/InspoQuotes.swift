//
//  InspoQuotes.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 11/3/21.
//

import Foundation


struct ResponseData: Decodable {
    var quote: [Quote]
}
struct Quote : Decodable {
    var quote: String
    var author: String
}

//example
struct Book: Codable, Identifiable {
    let id = UUID()
    var author: String
    var email: String
    var title: String
}

func loadJson(filename fileName: String) -> [Quote]? {
    if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(ResponseData.self, from: data)
            return jsonData.quote
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}

//example
class Api : ObservableObject{
    @Published var books = [Book]()
    
    func loadData(completion:@escaping ([Book]) -> ()) {
        guard let url = URL(string: "https://training.xcelvations.com/data/books.json") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let books = try! JSONDecoder().decode([Book].self, from: data!)
            print(books)
            DispatchQueue.main.async {
                completion(books)
            }
        }.resume()
        
    }
}
