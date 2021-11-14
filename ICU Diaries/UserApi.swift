//
//  UserApi.swift
//  ICU Diaries
//
//  Created by Kenneth Chou on 11/14/21.
//

import Foundation

struct User : Codable, Identifiable {
    let id = UUID()
    var firstName : String
    var lastName : String
    var username : String
    var password : String
    var email : String
    
    var proPic : String
}
