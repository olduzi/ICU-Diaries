//
//  ContentView.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 10/12/21.
//

import SwiftUI

//example
struct ContentView: View {
    
    @State var entries = Entry(diary_id: 13, sender_id: 13, receiver_id: 13, created_time: "time", title: "Test Post", content: "Success")
    @State var content = "hello"
    
    var body: some View {
        Text("\(content)")
            .onAppear() {
                GetDiary().sendData(entry: entries) { (response) in
                    self.content = response
                }
            }.navigationTitle("Quote List")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
