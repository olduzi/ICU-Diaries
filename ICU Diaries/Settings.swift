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
    @State var alreadyExists: Bool = false
    
    @State private var currentUser = UpdatedUser(user_id: 0, first_name: "", last_name: "", username: "", password1: "", password2: "")
    
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
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
            .onAppear() {
                self.currentUser.user_id = user_id
                EditUser().getUser(user_id: user_id) { (response) in
                    self.currentUser.first_name = response.first_name
                    self.currentUser.last_name = response.last_name
                    self.currentUser.username = response.username
                }
            }
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
                        TextField("First", text: $currentUser.first_name)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5.0)
                        TextField("Last", text: $currentUser.last_name)
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
                        Text("New Password: ")
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
                    .padding(.bottom, 10)
                    Text("\(checkpassword())")
                        .font(.title2)
                    Spacer()
                    HStack {
                        Button(action: {
                            EditUser().updateUser(entry: currentUser) { (statusCode) in
                                if statusCode != 200 {
                                    self.alreadyExists = true
                                    currentUser.username = ""
                                }
                                else {
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }) {
                            Text("Save")
                                .foregroundColor(Color.black)
                                .font(.title2)
                                .frame(width: 100)
                        }
                        .alert(isPresented: $alreadyExists) {
                            Alert(
                              title: Text("Username already taken")
                            )
                        }
                        .padding()
                        .background(Color.white)
                        .clipShape(Capsule())
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
