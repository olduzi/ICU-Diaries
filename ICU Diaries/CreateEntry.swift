//
//  CreateEntry.swift
//  ICU Diary
//
//  Created by Lingjun Sun on 10/10/21.
//

import SwiftUI


extension Color {
    static let baseGreen = Color(red: 166 / 255, green: 193 / 255, blue: 177 / 255)
}


struct customViewModifier: ViewModifier {
    var roundedCornes: CGFloat
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(roundedCornes)
            .padding(3)
            .foregroundColor(textColor)
            .overlay(RoundedRectangle(cornerRadius: roundedCornes))
            .font(.custom("Open Sans", size: 11))
            .shadow(radius: 10)
    }
}


struct TextFieldWrap: View {
    var textField: TextField<Text>
    var body: some View {
        HStack {
            textField.font(.title2)
                .foregroundColor(Color.black)
            }
        .padding(.trailing, 6.0)
            .foregroundColor(Color.baseGreen)
        .background(Color.white)
            .cornerRadius(6)
            .shadow(color: Color.white, radius: 3, x: 2, y: 2)
            .shadow(color: Color.white, radius: 3, x: -2, y: -2)
            
        }
}

struct CreateEntryView: View {
    @State var fontSize = 11;
    @State var title = "Enter Your Title";
    @State var EntryDate = Date();
    @State var content = "Main Content";
    var body: some View {
            Color.baseGreen.ignoresSafeArea()
                .overlay(
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Button(action:{
                        //TODO: Add Entry Funtionality
                    }) {
                        Text("Create New Entry:").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).fontWeight(.bold)
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
//                        .frame(height: 300.0)
                        .cornerRadius(16)
                        .overlay(
                            TextEditor(text: $content)
                                .foregroundColor(.primary)
                                .padding(.horizontal)
                                .navigationTitle("About you")
                        )

                }
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
                }
                Spacer()
            }
            .padding()
        )
        }

    }

struct CreateEntry_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CreateEntryView()
        }
    }
}
