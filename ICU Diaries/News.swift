//
//  News.swift
//  ICU Diaries
//
//  Created by Simran  Chowdhry on 11/14/21.
//

import Foundation
import SwiftUI

struct News: Codable {
    var value:[Article]
}

struct Article:Codable, Identifiable {
    let id = UUID()
    var name:String
    var url:String
    
}

class GetNews : ObservableObject{
    
    let API_KEY = "b93e1ddd56msh7542897a760385cp1a1551jsn718bdf124c45"
    let host = "bing-news-search1.p.rapidapi.com"
    
    func loadData(completion:@escaping ([Article]) -> ()) {

        var urlBuilder = URLComponents(string: "https://bing-news-search1.p.rapidapi.com/news")
            urlBuilder?.queryItems = [
                URLQueryItem(name: "headlineCount", value: "3")
            ]

        guard let url = urlBuilder?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(host, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(API_KEY, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("true", forHTTPHeaderField: "x-bingapis-sdk")

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            let response = try! JSONDecoder().decode(News.self, from: data!)
            guard let data = data else { return }
            let _ = print(String(data: data, encoding: .utf8)!)
            DispatchQueue.main.async {
                completion(response.value)
            }
        }.resume()
        
    }
    
}

struct NewsView: View {
    @State var news = [Article]()

    var body: some View {
        List(news) { new in
            
            VStack(alignment: .leading) {
                
                Text("\(new.name)")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding(.bottom)
                Spacer()
            }
            
        }
            .onAppear() {
                GetNews().loadData { (books) in
                    self.news = books
                }
            }
        .frame(width: 355.25, height: 369.95)
        .cornerRadius(20)
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
