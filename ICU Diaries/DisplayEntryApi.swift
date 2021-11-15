//
//  DisplayEntryApi.swift
//  ICU Diaries
//
//  Created by Simran  Chowdhry on 11/14/21.
//

import Foundation


struct AllEntriesGivenDate : Codable, Identifiable {
    let id = UUID()
    var user_id: Int?
    var date: Date?
    
    init(user_id: Int, date: Date) {
        self.user_id = nil
        self.date = nil
    }
}

struct DiaryEntry : Codable, Identifiable {
    let id = UUID()
    var diary_id: Int?

    
    init(diary_id: Int) {
        self.diary_id = nil
    }
}

class DisplayEntry : ObservableObject{
    
    //sends data to create user
    func allEntries(entry: AllEntriesGivenDate, completion:@escaping (String) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/diary/receiver") else {
            print("Invalid url...")
            return
        }
        
        let body: [String : Any] = ["user_id": entry.user_id!, "date": entry.date!]
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
    
    //sends data to create user
    func login(entry: DiaryEntry, completion:@escaping (String) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/diary/single") else {
            print("Invalid url...")
            return
        }
        
        let body: [String : Any] = ["diary_id": entry.diary_id]
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
