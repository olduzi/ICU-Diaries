//
//  Dashboard.swift
//  ICU-Diary
//
//  Created by Kenneth Chou on 10/12/21.
//

import SwiftUI

struct Note: Identifiable {
    var id = UUID()
    var title: String
}

struct Dashboard: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var rootIsActive : Bool
    @Binding var user_id : Int
    @State private var date = Date()
    @State private var parameters = AllEntriesGivenDate(user_id: 6, date: "")
    
    @State private var user = "Ken"
    @State private var isHidden = false
    
    func getTimeOfDay() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)

        if hour >= 5 && hour < 12 {
            return "morning"
        }
        else if hour >= 12 && hour < 17 {
            return "afternoon"
        }
        else if hour >= 17 && hour < 20 {
            return "evening"
        }
        else {
            return "night"
        }
    }
    
    @State var entries = [Entry]()
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
            .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading) {
                    HStack() {
                        Text("Good \(getTimeOfDay()) \(user_id)!")
//                            .onAppear (
//
//                            )
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        NavigationLink(destination: Settings(rootIsActive: self.$rootIsActive, user_id: self.$user_id)) {
                            Image("Settings")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .cornerRadius(20)
                                .offset(x: -20)
                        }
                        .isDetailLink(false)
                    }
                    .padding()
                    HStack() {
                        VStack() {
                            // Date Picker and List
                            DatePicker(
                                "Date:",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .onChange(of: date, perform: { value in
                                parameters.date = Date.getISOTimestamp(date: self.date)
                                DisplayEntry().allEntries(entry: parameters) { (entries) in
                                    self.entries = entries
                                }
                            })
                            List(entries, id: \.id) { entry in
                                NavigationLink(destination: DiaryEntryView(rootIsActive: self.$rootIsActive, user_id: self.$user_id, entry: entry, selectedDate: $date, userName: $user)) {
                                    Text("\(entry.title ?? "")")
                                }
                            }
                                .onAppear() {
                                    parameters.user_id = self.user_id
                                    parameters.date = Date.getISOTimestamp(date: self.date)
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
    //                                Button("Create new entry +", action: { createNote()
    //                                })
    //                                .buttonStyle(DefaultButtonStyle())
    //                                .padding()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        VStack() {
                            // Widgets
                            QuotesView()
                            Spacer()
//                            WeatherView()
                            Color(red: 0, green: 0, blue: 1)
                                .frame(width: 353.15, height: 164.5)
                                .cornerRadius(10)
                            Spacer()
                            Toggle("Hide News", isOn: $isHidden)
                                .padding(.init(top: 0, leading: 20, bottom: 5, trailing: 20))
//                            if !isHidden {
//                                NewsView()
//                            }
//                            else {
                                Color(red: 1, green: 1, blue: 1)
                                    .frame(width: 355.25, height: 369.95)
                                    .cornerRadius(20)
//                            }
                            Spacer()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .padding()
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .offset(x: 10)
                .offset(y: -40)
            )
    }
}

#if DEBUG
struct Dashboard_Previews : PreviewProvider {
    static var previews: some View {
        Dashboard(rootIsActive: .constant(false), user_id: .constant(9))
    }
}
#endif

