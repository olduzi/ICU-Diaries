//
//  EditEntry.swift
//  ICU Diary
//
//  Created by Lingjun Sun on 10/10/21.
//

import SwiftUI


struct EditEntryView: View {
    @State var fontSize = 11;
    // TODO: replace title with api title
    @State var title = "Message from Dr. Valley";
    // TODO: replace date with api date
    @State var EntryDate = Date();
    // TODO: replace hardcoded content with api content
    @State var content = "Today doctors will discuss the treatment of patient Justin.";
    var body: some View {
        ZStack{
            Color.baseGreen.ignoresSafeArea()
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Button(action:{
                        //TODO: Add Entry Funtionality
                    }) {
                        Text("Edit Entry:").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.bold)
                    }
                    .padding(.bottom)
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    Spacer()
                }
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    Text("Title").font(.title2).fontWeight(.regular)
                    TextFieldWrap(textField: TextField(title, text: $title))
                })
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                    DatePicker(selection: $EntryDate, in: ...Date(), displayedComponents: .date) {
                        Text("Select a date")
                            .font(.title2)
                                }
                })
                VStack(alignment: .leading) { // Entry Box
                    Text("Enter Content: ").font(.title2).fontWeight(.bold)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .padding(.bottom, -150)
                        .padding(.top, 50).offset(x: 0, y: -50)
                        .shadow(color: Color.black, radius: 4, x: 2, y: 2)
                        .shadow(color: Color.white, radius: 3, x: -15, y: -2)
                        .padding(.horizontal, 4.0)
                        .frame(height: 300.0)
                        .cornerRadius(16)
                        .overlay(
                            TextEditor(text: $content)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                                .navigationTitle("About you")
                        )

                }
            }
        }

    }
}

struct EditEntry_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EditEntryView()
        }
    }
}
