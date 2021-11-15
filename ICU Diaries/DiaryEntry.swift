//
//  DiaryEntry.swift
//  ICU Diaries
//
//  Created by Kenneth Chou on 11/9/21.
//

import SwiftUI

struct DiaryEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var rootIsActive : Bool
    @Binding var user_id : Int
    
    let entry : Entry

    @Binding var selectedDate : Date
    @Binding var userName : String
    
    @State var entries = [Entry]()

    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
            .ignoresSafeArea()
            .overlay(
                VStack() {
                    Text("\(userName)'s Diary")
                        .font(.largeTitle)
                        .bold()
                    HStack() {
                        VStack() {
                            // Date Picker and List
                            DatePicker(
                                "Date:",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                            )
                            List(entries) { entry in
                                Text("\(entry.title ?? "")")
                            }
                                .onAppear() {
                                    GetDiary().loadData { (entries) in
                                        self.entries = entries             }
                                }
                            Spacer()
                            NavigationLink(destination: CreateEntryView(rootIsActive: self.$rootIsActive, user_id: self.$user_id)) {
                                Text("Create new entry +")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding()
                                .frame(width: 390, height: 60)
                                .background(Color.white)
                                .cornerRadius(15.0)
                            }
                            .isDetailLink(false)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        VStack() {
                            Spacer()
                            Text("\(entry.content ?? "")")
                            Spacer()
                            NavigationLink(destination: CreateEntryView(rootIsActive: self.$rootIsActive, user_id: self.$user_id)) {
                                Text("Edit entry")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .padding()
                                .frame(width: 390, height: 60)
                                .background(Color.white)
                                .cornerRadius(15.0)
                            }
                            .isDetailLink(false)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .padding()
                    Spacer()
                }
                .offset(x: 10)
                .offset(y: -40)
            )
    }
}

//#if DEBUG
//struct DiaryEntry_Previews: PreviewProvider {
//    static var previews: some View {
//        DiaryEntryView(rootIsActive: .constant(false), entry: .constant(Entry(diary_id: 1, sender_id: 1, receiver_id: 1, created_time: "", title: "Message from .", content: "Hello!")), selectedDate: .constant(Date()), userName: .constant("Ken"))
//    }
//}
//#endif

struct DiaryEntry_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
