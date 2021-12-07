//
//  CreateEntry.swift
//  ICU Diary
//
//  Created by Lingjun Sun on 10/10/21.
//

import SwiftUI

struct CreateEntryView: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var rootIsActive : Bool
    @Binding var user_id : Int

    @State var newEntry = NewEntry(sender_id: 0, receiver_name: "", title: "", content: "")
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
            .onAppear() {
                newEntry.sender_id = user_id
            }
            .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading) {
                    Text("Create New Entry:")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    HStack() {
                        Text("Title: ")
                            .font(.title2)
                            .fontWeight(.regular)
                        TextField("", text: $newEntry.title)
                            .autocapitalization(.none)
                            .font(.title2)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom)
                    Text("Content: ")
                        .font(.title2)
                        .padding(.bottom)
                    TextEditor(text: $newEntry.content)
                        .autocapitalization(.none)
                        .font(.title2)
                        .cornerRadius(10)
                        .padding(.bottom)
                    HStack() {
                        Text("Recipient: ")
                            .font(.title2)
                            .fontWeight(.regular)
                        TextField("", text: $newEntry.receiver_name)
                            .autocapitalization(.none)
                            .font(.title2)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom)
                    Spacer()
                    Button(action: {
                        GetDiary().sendData(entry: newEntry) { _ in }
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(Color.black)
                            .font(.title2)
                            .frame(width: 100)
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(Capsule())
                }
                .padding()
            )
    }
}

#if DEBUG
struct CreateEntry_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateEntryView(rootIsActive: .constant(false), user_id: .constant(6))
        }
    }
}
#endif
