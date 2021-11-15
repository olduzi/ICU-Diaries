//
//  LoginApi.swift
//  ICU Diaries
//
//  Created by Simran  Chowdhry on 11/14/21.
//

import Foundation

struct UserData: Codable {
    var contents:[Users]
}

struct LoginUsers : Codable, Identifiable {
    let id = UUID()
    var username: String?
    var password: String?
    
    init(username: String, password: String) {
        self.username = nil
        self.password = nil
    }
}

struct CreateUsers : Codable, Identifiable {
    let id = UUID()
    var username: String?
    var email: String?
    var password1: String?
    var password2: String?
    var firstname: String?
    var lastname: String?
    
    init(usernane: String, email: String, password1: String, password2: String, firstname: String, lastname: String) {
        self.username = nil
        self.email = nil
        self.password1 = nil
        self.password2 = nil
        self.firstname = nil
        self.lastname = nil
    }
}

class GetLogin : ObservableObject{
    
    //sends data to create user
    func createUser(entry: CreateUsers, completion:@escaping (String) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/accounts/register/") else {
            print("Invalid url...")
            return
        }
        
        let body: [String : Any] = ["username": entry.username!, "email": entry.email!, "password1": entry.password1!, "password2": entry.password2!, "firstname": entry.firstname!, "lastname": entry.lastname!]
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
    func login(entry: LoginUsers, completion:@escaping (String) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/accounts/login/") else {
            print("Invalid url...")
            return
        }
        
        let body: [String : Any] = ["username": entry.username!, "password": entry.password!]
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
