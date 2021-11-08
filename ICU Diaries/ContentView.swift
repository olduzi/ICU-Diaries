//
//  ContentView.swift
//  ICU Diaries
//
//  Created by Olduz Ilkhchoui on 10/12/21.
//

import SwiftUI

//example
struct ContentView: View {
    
    @State var books = [Book]()
    
    var body: some View {
        List(books) { book in
            Text("\(book.author)")
        }
            .onAppear() {
                Api().loadData { (books) in
                    self.books = books
                }
            }.navigationTitle("Book List")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
