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
    @State private var date = Date()
    @State private var user = "Ken"
    
    @State var notes = [
        Note(title: "Today's Diary Entry"),
        Note(title: "Blood Test Results"),
        Note(title: "From: Mom")
    ]

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
    
    func createNote() -> Void {
        notes.append(Note(title: "New entry"))
    }
    
    var body: some View {
        Color(red: 0.65, green: 0.76, blue: 0.69)
            .ignoresSafeArea()
            .overlay(
                VStack(alignment: .leading) {
                    HStack() {
                        Text("Good \(getTimeOfDay()) \(user)!")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        NavigationLink(destination: Settings(rootIsActive: self.$rootIsActive)) {
                            Image("KennethChou")
                                .resizable()
                                .frame(width: 100, height: 66.6)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .offset(x: -10)
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
                            List(notes, id: \.id) { note in
                                Text(note.title)
                            }
                            Spacer()
                            NavigationLink(destination: CreateEntryView(rootIsActive: self.$rootIsActive)) {
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
                            Image("News")
                                .resizable()
                                .frame(width: 355.25, height: 369.95)
                                .cornerRadius(20)
                                .offset(y: -80)
                            Spacer()
                            Image("Weather")
                                .resizable()
                                .frame(width: 356.3, height: 167.3)
                                .cornerRadius(20)
                                .offset(y: -160)
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
        Dashboard(rootIsActive: .constant(false))
    }
}
#endif

