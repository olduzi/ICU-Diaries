//
//  Login.swift
//  ICU Diary
//
//  Created by Simran  Chowdhry on 10/11/21.
//

import SwiftUI

struct Login : View {
    @State var isActive : Bool = false
    
    @State var credentials = LoginUsers(username: "", password: "")
//    @State var username: String = ""
//    @State var password: String = ""
    @State var user_id : Int = 0
    
    var body: some View {
        NavigationView {
            Color(red: 0.65, green: 0.76, blue: 0.69)
                    .ignoresSafeArea() // Ignore just for the color
                    .overlay(
            VStack {
                WelcomeText()
                TextField("Username", text: $credentials.username)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $credentials.password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                NavigationLink(destination: Dashboard(rootIsActive: self.$isActive, user_id: self.$user_id), isActive: self.$isActive) {
                    Text("SIGN IN")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
                }
                .isDetailLink(false)
                .simultaneousGesture(TapGesture().onEnded{
                    GetLogin().login(entry: credentials) { (user_id) in
                        self.user_id = user_id
                    }
                    credentials.username = ""
                    credentials.password = ""
                })
                Spacer()
                HStack() {
                    Text("New user?")
                    NavigationLink(destination: CreateUserView(rootIsActive: self.$isActive), isActive: self.$isActive) {
                        Text("Register here!")
                    }
                }
                .padding(.top)
            }
//            .offset(y: -100)
            .padding()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}

struct WelcomeText: View {
    var body: some View {
        VStack {
            Text("Welcome to ICU Diary!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
        }
    }
}

struct UserImage : View {
    var body: some View {
        VStack {
            return Image("userImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipped()
                .cornerRadius(150)
                .padding(.bottom, 75)
        }
    }
}

struct LoginButton : View {
    var body: some View {
        VStack {
            Text("SIGN IN")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(user_id: 1)
    }
}
