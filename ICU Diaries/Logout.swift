//
//  Logout.swift
//  ICU Diary
//
//  Created by Simran  Chowdhry on 10/11/21.
//

import SwiftUI

struct LogOut: View {
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
        VStack {
            ICUDiaryText()
            LogoutQuestionText()
            NavigationLink(destination: Login()) {
                                Text("Awesome Button")
                                .frame(minWidth: 0, maxWidth: 300)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(40)
                                .font(.title)
            }
            Button(action: {print("Button tapped")}) {
                           LogoutYesButton()
                        }
            Button(action: {print("Button tapped")}) {
                           LogoutNoButton()
                        }
        }
                )
    }
}


struct ICUDiaryText: View {
    var body: some View {
        VStack {
            Text("ICU Diary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
        }
    }
}


struct LogoutQuestionText: View {
    var body: some View {
        VStack {
            Text("Are you sure you want to logout?")
                .fontWeight(.semibold)
                .padding(.bottom, 20)
        }
    }
}

struct LogoutYesButton : View {
    var body: some View {
        VStack {
            Text("YES")
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


struct LogoutNoButton : View {
    var body: some View {
        VStack {
            Text("NO")
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

struct Logout_Previews: PreviewProvider {
    static var previews: some View {
        LogOut()
    }
}
