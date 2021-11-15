//
//  CreateUser.swift
//  ICU Diaries
//
//  Created by Kenneth Chou on 11/10/21.
//

import SwiftUI

struct CreateUserView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var rootIsActive : Bool
    
    @State private var newUser = CreateUsers(firstName: "", lastName: "", username: "", password1: "", password2: "") // initialize differently
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(alignment: .leading) {
                        Text("Create Profile")
                            .font(.largeTitle)
                            .bold()
                            .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Name: ")
                                .font(.title2)
                            TextField("First", text: $newUser.firstName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                            TextField("Last", text: $newUser.lastName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
//                        HStack(alignment: .center) {
//                            Text("Email: ")
//                                .font(.title2)
//                            TextField("Email", text: $newUser.email)
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(5.0)
//                        }
//                        .padding(.bottom, 10)
//                        HStack(alignment: .center) {
//                            Text("Profile Picture: ")
//                                .font(.title2)
//                            TextField("Ken.jpeg", text: $newUser.proPic)
//                                .padding()
//                                .background(Color.white)
//                                .cornerRadius(5.0)
//                            Button("Choose photo", action: {})
//                            Spacer()
//                        }
//                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Username: ")
                                .font(.title2)
                            TextField("Username", text: $newUser.username)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Password: ")
                                .font(.title2)
                            SecureField("Password", text: $newUser.password1)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Confirm Password: ")
                                .font(.title2)
                            SecureField("Password", text: $newUser.password2)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
                        Spacer()
                        HStack {
                            Button(action: {}) {
                                Text("Save")
                                    .foregroundColor(Color.black)
                                    .font(.title2)
                                    .frame(width: 100)
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                            Button ("Cancel", action: {self.presentationMode.wrappedValue.dismiss()})
                            .foregroundColor(Color.black)
                            .font(.title2)
                            .frame(width: 100)
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
struct CreateUser_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView(rootIsActive: .constant(false))
    }
}
#endif
