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

struct LoginUsers : Codable, Identifiable {
    let id = UUID()
    var username: String
    var password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

struct CreateUsers : Codable, Identifiable {
    let id = UUID()
    var firstName: String
    var lastName: String
    var username: String
    var password1: String
    var password2: String
    
    init(firstName: String, lastName: String, username: String, password1: String, password2: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password1 = password1
        self.password2 = password2
    }
}

class GetLogin : ObservableObject{
    
    //sends data to create user
    func createUser(entry: CreateUsers, completion:@escaping (String) -> ()) {
        guard let url = URL(string: "http://68.58.243.157:8000/api/accounts/register/") else {
            print("Invalid url...")
            return
        }
        
        let body: [String : Any] = ["firstName": entry.firstName, "lastName": entry.lastName, "username": entry.username,  "password1": entry.password1, "password2": entry.password2]
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
    func login(entry: LoginUsers, completion:@escaping (Int) -> ()) {
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
            let response = try! JSONDecoder().decode(LoginResponse.self, from: data!)
            guard let data = data else { return }
            let _ = print(String(data: data, encoding: .utf8)!)
            DispatchQueue.main.async {
                completion(response.user_id)
            }
        }.resume()
    }
    
}

struct LoginTest: View {
    @State var entries = LoginUsers(username: "slingjun2", password: "icudiary42021")
    @State var user_id : Int

    var body: some View {
        Text("\(user_id)")
            .onAppear() {
                GetLogin().login(entry: entries) { (response) in
                        self.user_id = response
                    }
                }.navigationTitle("Quote List")
        }
}

struct LoginTest_Previews: PreviewProvider {
    static var previews: some View {
        LoginTest(user_id: 0)
    }
}
