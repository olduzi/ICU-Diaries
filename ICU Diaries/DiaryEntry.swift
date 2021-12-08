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
    @Binding var selectedDate : Date
    @Binding var user : String
    @State var diary_id: Int
    
    @State private var entry = Entry(diary_id: 0, sender_id: 0, receiver_id: 0, title: "", content: "")
    @State var entries = [Entry]()
    @State private var parameters = FetchEntriesRequest(user_id: 0, date: "")
    @State private var isOwner = false

    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
            .ignoresSafeArea()
            .onAppear(
                perform: {
                    DisplayEntry().single(diary_id: self.diary_id) { (entries) in
                        self.entry = entries[0]
                        if self.entry.sender_id == user_id {
                            isOwner = true
                        }
                        else {
                            isOwner = false
                        }
                    }
                }
            )
            .overlay(
                VStack() {
                    Text("\(user)'s Diary")
                        .font(.largeTitle)
                        .bold()
                        .onAppear() {
                            EditUser().getUser(user_id: user_id) { (response) in
                                self.user = response.first_name
                            }
                        }
                    HStack() {
                        VStack() {
                            // Date Picker and List
                            DatePicker(
                                "Date:",
                                selection: $selectedDate,
                                displayedComponents: [.date]
                            )
                            .onChange(of: selectedDate, perform: { value in
                                parameters.date = Date.getISOTimestamp(date: self.selectedDate)
                                DisplayEntry().allEntries(entry: parameters) { (entries) in
                                    self.entries = entries
                                }
                            })
                            List(entries, id: \.id) { entry in
                                Button(action: {
                                    DisplayEntry().single(diary_id: entry.diary_id) {(entries) in
                                        self.entry = entries[0]
                                        if self.entry.sender_id == user_id {
                                            isOwner = true
                                        }
                                        else {
                                            isOwner = false
                                        }
                                    }
                                }) {
                                    Text("\(entry.title)")
                                }
                            }
                            .border(Color.black)
                            .onAppear() {
                                parameters.user_id = self.user_id
                                parameters.date = Date.getISOTimestamp(date: self.selectedDate)
                                DisplayEntry().allEntries(entry: parameters) { (entries) in
                                    self.entries = entries
                                }
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
                            Color(red: 0.65, green: 0.76, blue: 0.69)
                                .frame(height: 35)
                            Color(red: 1, green: 1, blue: 1)
                                .overlay(
                                    VStack() {
                                        Text("\(entry.title)")
                                            .font(.title2)
                                            .bold()
                                            .padding()
                                        Text("\(entry.content)")
                                            .padding(.init(top: 0, leading: 11, bottom: 20, trailing: 11))
                                        Spacer()
                                    }
                                )
                                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 950)
                                .border(Color.black)
                            if isOwner {
                                NavigationLink(destination: EditEntryView(rootIsActive: self.$rootIsActive, diary_id: $entry.diary_id)) {
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
                            else {
                                Color(red: 0.65, green: 0.76, blue: 0.69)
                                    .frame(width: 390, height: 60)
                                    .cornerRadius(15)
                            }
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    } // HStack
                    .padding()
                    Spacer()
                } // VStack
                .offset(y: -40)
            )
    }
}

#if DEBUG
struct DiaryEntry_Previews: PreviewProvider {
    var entry = Entry(diary_id: 1, sender_id: 9, receiver_id: 9, title: "December 6th Update", content: "Did well today!")
    
    static var previews: some View {
        DiaryEntryView(rootIsActive: .constant(false), user_id: .constant(9), selectedDate: .constant(Date()), user: .constant("Ken"), diary_id: 140)
    }
}
#endif
