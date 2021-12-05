//
//  Logout.swift
//  ICU Diary
//
//  Created by Simran  Chowdhry on 10/11/21.
//

import SwiftUI

struct Logout : View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var shouldPopToRootView : Bool
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
        .ignoresSafeArea() // Ignore just for the color
        .overlay(
            VStack {
                ICUDiaryText()
                LogoutQuestionText()
                Button("YES", action: {self.shouldPopToRootView = false})
                .frame(minWidth: 0, maxWidth: 300)
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(40)
                .font(.title)
                Button("NO", action: {self.presentationMode.wrappedValue.dismiss()})
                .frame(minWidth: 0, maxWidth: 300)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
                .font(.title)
            }
            .offset(y: -100)
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
                .font(.title2)
                .padding(.bottom, 20)
        }
    }
}

//struct LogoutYesButton : View {
//    var body: some View {
//        NavigationLink(destination: Login()) {
//            Text("YES")
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding()
//                .frame(width: 220, height: 60)
//                .background(Color.green)
//                .cornerRadius(15.0)
//        }
//        .padding()
//    }
//}
//
//
//struct LogoutNoButton : View {
//    var body: some View {
//        NavigationLink(destination: Dashboard()) {
//            Text("NO")
//                .font(.headline)
//                .foregroundColor(.white)
//                .padding()
//                .frame(width: 220, height: 60)
//                .background(Color.green)
//                .cornerRadius(15.0)
//        }
//        .padding()
//    }
//}

//struct Logout_Previews: PreviewProvider {
//    static var previews: some View {
//        Logout()
//    }
//}
