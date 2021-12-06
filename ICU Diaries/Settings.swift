//
//  Settings.swift
//  ICU Diary
//
//  Created by Olduz Ilkhchoui on 10/10/21.
//
import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var rootIsActive : Bool
    @Binding var user_id : Int
    
    @State private var currentUser = CreateUsers(firstName: "", lastName: "", username: "", password1: "", password2: "", email: "") // initialize differently
    
    // @State private var currentUser = getUser(diary_id)
    
    func checkpassword() -> String {
        let firstPass = currentUser.password1
        let secondPass = currentUser.password2
        
        if firstPass != "" && secondPass != "" {
            if firstPass == secondPass {
                return "Passwords match"
            }
            else {
                return "Passwords don't match"
            }
        }
        else {
            return ""
        }
    }
    
    func errorCheck() -> Bool {
        let firstPass = currentUser.password1
        let secondPass = currentUser.password2
        let userName = currentUser.username
        let name = currentUser.firstName
        let lastName = currentUser.lastName
        if firstPass == "" || secondPass == "" || userName == "" || name == "" || lastName == "" {
            return true
        }
        else if checkpassword() == "Passwords don't match" {
            return true
        }
        else {
            return false
        }
    }
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(alignment: .leading) {
                        HStack(alignment: .center) {
                            Text("Edit Profile")
                                .font(.largeTitle)
                                .bold()
                            Spacer()
                            NavigationLink(destination: Logout(shouldPopToRootView: self.$rootIsActive)) {
                                Text("Logout")
                                    .foregroundColor(Color.black)
                                    .font(.title2)
                                    .frame(width: 100)
                                    .padding()
                                    .background(Color(red: 0.98, green: 0.49, blue: 0.49))
                                    .clipShape(Capsule())
                            }
                            .isDetailLink(false)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Name: ")
                                .font(.title2)
                            TextField("First", text: $currentUser.firstName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                            TextField("Last", text: $currentUser.lastName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Username: ")
                                .font(.title2)
                            TextField("Username", text: $currentUser.username)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Password: ")
                                .font(.title2)
                            SecureField("Password", text: $currentUser.password1)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Confirm Password: ")
                                .font(.title2)
                            SecureField("Password", text: $currentUser.password2)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        Text("\(checkpassword())")
                        .padding(.bottom, 10)
                        Spacer()
                        HStack {
                            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                Text("Save")
                                    .foregroundColor(Color.black)
                                    .font(.title2)
                                    .frame(width: 100)
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                            .disabled(errorCheck())
//                            Button ("Cancel", action: {self.presentationMode.wrappedValue.dismiss()})
//                            .foregroundColor(Color.black)
//                            .font(.title2)
//                            .frame(width: 100)
//                            .padding()
//                            .background(Color.white)
//                            .clipShape(Capsule())
                        }
                    }
                    .offset(y: -40)
                    .padding()
                )


    }
}

#if DEBUG
struct Settings_Previews : PreviewProvider {
    static var previews: some View {
        Settings(rootIsActive: .constant(false), user_id: .constant(1))
    }
}
#endif
