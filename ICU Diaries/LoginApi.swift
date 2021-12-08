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

class GetLogin : ObservableObject{
//    @Published var user_id = 0
//
//
//    func login(entry: LoginUsers) {
//        guard let url = URL(string: "http://68.58.243.157:8000/api/accounts/login/") else { fatalError("Missing URL") }
//
//        let body: [String : Any] = ["username": entry.username, "password": entry.password]
//        let finalBody = try! JSONSerialization.data(withJSONObject: body)
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.httpBody = finalBody
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                DispatchQueue.main.async {
//                    do {
//                        let decodedUsers = try JSONDecoder().decode(LoginResponse.self, from: data)
//                        self.user_id = decodedUsers.user_id
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//
//        dataTask.resume()
//    }
    
    //sends data to create user
    func createUser(entry: User, completion:@escaping (Int, Int) -> ()) {
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
                if response.statusCode == 200 {
                    let URLresponse = try! JSONDecoder().decode(LoginResponse.self, from: data)
                    completion(URLresponse.user_id, response.statusCode)
                }
                else {
                    completion(0, response.statusCode)
                }
            }
        }.resume()
    }
    
    //sends data to create user
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

//struct LoginTest: View {
//    @State var entries = LoginUsers(username: "slingjun2", password: "icudiary42021")
//    @State var user_id : Int
//
//    var body: some View {
//        Text("\(user_id)")
//            .onAppear() {
//                GetLogin().login(entry: entries) { (response) in
//                        self.user_id = response
//                    }
//                }.navigationTitle("Quote List")
//        }
//}

//struct LoginTest_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginTest(user_id: 0)
//    }
//}
