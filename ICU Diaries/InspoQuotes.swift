//
//  InspoQuotes.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 11/3/21.
//

import Foundation
import SwiftUI


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
            let response = try! JSONDecoder().decode(ResponseData.self, from: data!)
            DispatchQueue.main.async {
                completion(response.quotes)
            }
        }.resume()
        
    }
}

struct QuotesView: View {
    @State var quotes = [Quote]()
    @State var quote = ""
    @State var author = ""
    
    let randomInt = Int.random(in: 0..<10)
    
    var body: some View {
        VStack {
            Text("\"\(quote)\" - \(author)")
                .padding()
                .onAppear() {
                    Api().loadData { (quotes) in
                        self.quotes = quotes
                        self.quote = quotes[randomInt].quote
                        self.author = quotes[randomInt].author
                    }
                }
                .frame(width: 353.15, height: 164.5)
                .background(Color.black)
                .foregroundColor(Color.white)
                .cornerRadius(10.0)
                
        }
    }
}

struct QuotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView()
    }
}
