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
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
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
                                    .offset(y: -10)
                            }
                            .isDetailLink(false)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Name: ")
                                .font(.title2)
                            TextField("Name", text: .constant("Ken"))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
                        .padding(.bottom, 10)
                        HStack(alignment: .center) {
                            Text("Profile Picture: ")
                                .font(.title2)
                            TextField("Profile Picture", text: .constant("Ken.jpeg"))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                            Button("Choose photo", action: {})
                            Spacer()
                        }
                        .padding(.bottom, 10)
                        HStack (alignment: .center) {
                            Text("Date of Birth: ")
                                .font(.title2)
                            TextField("Date of Birth", text: .constant("August 9, 2000"))
                                .padding()
                                .background(Color.white)
                                .cornerRadius(5.0)
                        }
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

//struct Settings_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Settings()
//        }
//    }
//}
