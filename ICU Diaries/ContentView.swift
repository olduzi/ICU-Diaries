//
//  ContentView.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 10/12/21.
//

import SwiftUI

//example
struct ContentView: View {
    
    @State var entries = [Entry]()
    @State var content = "hello"
    
    var body: some View {
//        List(entries) { entry in
//            Text("\(entry.content)")
//        }
        Text("\(content)")
            .onAppear() {
                GetDiary().loadData { (data) in
                    self.content = data             }
            }.navigationTitle("Quote List")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
