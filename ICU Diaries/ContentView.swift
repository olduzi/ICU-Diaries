//
//  ContentView.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 10/12/21.
//

import SwiftUI

//example
struct ContentView: View {
    
    @State var entries = Entry(sender: "olduzi", reciever: "olduzi", title: "Test Post", content: "Successful Post")
    @State var content = "hi"
    
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
