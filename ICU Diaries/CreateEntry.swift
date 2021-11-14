//
//  CreateEntry.swift
//  ICU Diary
//
//  Created by Lingjun Sun on 10/10/21.
//

import SwiftUI

struct CreateEntryView: View {
    @Binding var rootIsActive : Bool

    @State var title = "";
    @State var date = Date();
    @State var content = "";
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
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
                        TextField("", text: $title)
                            .font(.title2)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    DatePicker(
                        "Date:",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .font(.title2)
                    .padding(.bottom)
                    Text("Content: ")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    TextEditor(text: $content)
                        .font(.title2)
                        .cornerRadius(10)
                        .padding(.bottom)
                    Button(action: {}) {
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
            CreateEntryView(rootIsActive: .constant(false))
        }
    }
}
#endif
