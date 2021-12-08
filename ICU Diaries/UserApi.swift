//
//  UserApi.swift
//  ICU Diaries
//
//  Created by Kenneth Chou on 12/6/21.
//

import Foundation
import SwiftUI

struct GetUserResponse : Codable {
//    var user_id: Int
    var first_name: String
    var last_name: String
    var username: String
}

struct UpdatedUser : Codable {
    var user_id: Int
    var first_name: String
    var last_name: String
    var username: String
    var password1: String
    var password2: String
}

class EditUser : ObservableObject {
    func getUser(user_id: Int, completion:@escaping (GetUserResponse) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/accounts/profile?user_id=\(user_id)") else {
            print("Invalid url...")
            return
        }
 
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let response = try! JSONDecoder().decode(GetUserResponse.self, from: data!)
            guard let data = data else { return }
            let _ = print(String(data: data, encoding: .utf8)!)
            DispatchQueue.main.async {
                completion(response)
            }
        }.resume()
    }
    
    func updateUser(entry: UpdatedUser, completion:@escaping (Int) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/accounts/profile/") else {
            print("Invalid url...")
            return
        }

        let body: [String : Any] = ["user_id": entry.user_id, "first_name": entry.first_name, "last_name": entry.last_name, "username": entry.username, "password1": entry.password1, "password2": entry.password2]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Accept", forHTTPHeaderField: "Vary")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                completion(response.statusCode)
            }
        }.resume()
    }
}
