//
//  ContentView.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 10/12/21.
//

import SwiftUI

//example
struct ContentView: View {
    
    @State var quotes = [Quote]()
    
    var body: some View {
        List(quotes) { quote in
            Text("\(quote.author)")
        }
            .onAppear() {
                Api().loadData { (quotes) in
                    self.quotes = quotes
                }
            }.navigationTitle("Quote List")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
