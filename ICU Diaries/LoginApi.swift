//
//  LoginApi.swift
//  ICU Diaries
//
//  Created by Simran  Chowdhry on 11/14/21.
//

import Foundation
import SwiftUI

struct LoginResponse : Codable {
    var user_id : Int
}

struct LoginUser : Codable {
    var username: String
    var password: String
}

struct User : Codable {
    var first_name: String
    var last_name: String
    var username: String
    var password1: String
    var password2: String
}

struct CreateResponse : Codable {
    var key : String?
    var user_id : Int?
    var username: [String]?
    var password1: [String]?
    var password2: [String]?
}

class GetLogin : ObservableObject{
    //sends data to create user
    func createUser(entry: User, completion:@escaping (CreateResponse, Int) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/accounts/register/") else {
            print("Invalid url...")
            return
        }
        
        let body: [String : Any] = ["first_name": entry.first_name, "last_name": entry.last_name, "username": entry.username,  "password1": entry.password1, "password2": entry.password2]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let _ = print(String(data: data, encoding: .utf8)!)
            guard let response = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                let URLresponse = try! JSONDecoder().decode(CreateResponse.self, from: data)
                completion(URLresponse, response.statusCode)
                
            }
        }.resume()
    }
    
    func login(entry: LoginUser, completion:@escaping (Int, Int) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/accounts/login/") else {
            print("Invalid url...")
            return
        }
        
        let body: [String : Any] = ["username": entry.username, "password": entry.password]
        let finalBody = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let response = response as? HTTPURLResponse else { return }
            DispatchQueue.main.async {
                if response.statusCode == 200 {
                    let URLresponse = try! JSONDecoder().decode(LoginResponse.self, from: data!)
                    completion(URLresponse.user_id, response.statusCode)
                }
                else {
                    completion(0, response.statusCode)
                }
            }
        }.resume()
    }
    
}
