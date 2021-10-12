//
//  Settings.swift
//  ICU Diary
//
//  Created by Olduz Ilkhchoui on 10/10/21.
//
import SwiftUI

struct Settings: View {
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
                .ignoresSafeArea() // Ignore just for the color
                .overlay(
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text("Edit Profile")
                                .font(.largeTitle)
                            Spacer()
                            Button(action: {}) {
                                Text("Logout")
                                    .foregroundColor(Color.black)
                                    .padding(.trailing)
                                    .font(.title)
                            }
                            .padding()
                            .background(Color(red: 0.98, green: 0.49, blue: 0.49))
                            .clipShape(Capsule())

                        }
                        HStack(alignment: .top) {
                            Text("Name: ")
                            TextEditor(text: /*@START_MENU_TOKEN@*/.constant("Placeholder")/*@END_MENU_TOKEN@*/)
                                .frame(height: 30.0)
                        }
                        HStack(alignment: .top) {
                            Text("Profile Picture: ")
                            TextEditor(text: /*@START_MENU_TOKEN@*/.constant("Placeholder")/*@END_MENU_TOKEN@*/)
                                .frame(height: 30.0)
                        }
                        Spacer()
                        HStack {
                            Button(action: {}) {
                                Text("Save")
                                    .foregroundColor(Color.black)
                                    .padding(.trailing)
                                    .font(.title)
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                            Button(action: {}) {
                                Text("Cancel")
                                    .foregroundColor(Color.black)
                                    .padding(.trailing)
                                    .font(.title)
                            }
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                        }
                    }
                    .padding()
                )


    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Settings()
        }
    }
}