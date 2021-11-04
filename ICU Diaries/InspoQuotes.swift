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
