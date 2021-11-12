//
//  TestApi.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 11/9/21.
//

import Foundation

struct DiaryResponse: Codable {
    var contents:[Entry]
}

struct Entry : Codable, Identifiable {
    let id = UUID()
    var diary_id: Int?
    var sender_id: Int?
    var receiver_id: Int?
    var sender: String?
    var reciever: String?
    var created_time: String?
//    var modified_time: String
    var title: String?
    var content: String?
    
    init(sender: String, reciever: String, title: String, content: String) {
        self.diary_id = nil
        self.sender_id = nil
        self.receiver_id = nil
        self.sender = sender
        self.reciever = reciever
        self.created_time = nil
        self.title = title
        self.content = content
    }
}

class GetDiary : ObservableObject{
    
    @Published var quotes = [Entry]()
    
    func loadData(completion:@escaping ([Entry]) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/diary/testing/") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let response = try! JSONDecoder().decode(DiaryResponse.self, from: data!)
            guard let data = data else { return }
            let _ = print(String(data: data, encoding: .utf8)!)
            DispatchQueue.main.async {
                completion(response.contents)
            }
        }.resume()
        
    }
    
    
    //sends a diary entry
    func sendData(entry: Entry, completion:@escaping (String) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/diary/new/") else {
            print("Invalid url...")
            return
        }
        
        let body: [String : Any] = ["sender": entry.sender!, "reciever": entry.reciever!, "created_time": entry.created_time!, "title": entry.title!, "content": entry.content!]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(response!.description)
            }
        }.resume()
        
        
    }
}
