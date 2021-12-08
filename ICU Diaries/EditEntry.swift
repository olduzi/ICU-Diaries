//
//  EditEntry.swift
//  ICU Diary
//
//  Created by Lingjun Sun on 10/10/21.
//

import SwiftUI


struct EditEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var rootIsActive : Bool
    @Binding var diary_id: Int

    @State private var data = Entry(diary_id: 0, sender_id: 0, receiver_id: 0, title: "", content: "")
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
            .onAppear() {
                DisplayEntry().single(diary_id: diary_id) { (data) in
                    self.data.diary_id = data[0].diary_id
                    self.data.title = data[0].title
                    self.data.content = data[0].content
                }
            }
            .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading) {
                    Text("Edit Entry:")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    HStack() {
                        Text("Title: ")
                            .font(.title2)
                            .fontWeight(.regular)
                        TextField("\(data.title)", text: self.$data.title)
                            .autocapitalization(.none)
                            .font(.title2)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom)
                    Text("Content: ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    TextEditor(text: self.$data.content)
                        .autocapitalization(.none)
                        .font(.title2)
                        .cornerRadius(10)
                        .padding(.bottom)
                    Spacer()
                    Button(action: {
                        DisplayEntry().updateEntry(entry: data) { _ in }
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
                .offset(y: -40)
                .padding()
            )
    }
}

#if DEBUG
struct EditEntry_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditEntryView(rootIsActive: .constant(false), diary_id: .constant(36))
        }
    }
}
#endif
