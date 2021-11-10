//
//  Login.swift
//  ICU Diary
//
//  Created by Simran  Chowdhry on 10/11/21.
//

import SwiftUI

struct Login : View {
    @State var isActive : Bool = false
    @State var username: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView {
            Color(red: 0.65, green: 0.76, blue: 0.69)
                    .ignoresSafeArea() // Ignore just for the color
                    .overlay(
            VStack {
                WelcomeText()
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                NavigationLink(destination: Dashboard(rootIsActive: self.$isActive), isActive: self.$isActive) {
                    Text("SIGN IN")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.green)
                    .cornerRadius(15.0)
                }
                .isDetailLink(false)
                .simultaneousGesture(TapGesture().onEnded{
                    self.username = ""
                    self.password = ""
                })
            }
            .offset(y: -100)
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
        Login()
    }
}
