//
//  ContentView.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 10/12/21.
//

import SwiftUI

struct ContentView: View {
    
//    var quotes = loadJson(filename: "quotes.json")!
    var temp = ["hello", "hi"]
    
    var body: some View {
        Text(temp[0])
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
