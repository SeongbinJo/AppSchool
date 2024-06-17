//
//  ContentView.swift
//  BookShelf
//
//  Created by 조성빈 on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    var books: [Book]
    
    var body: some View {
        BookListView()
    }
}
#Preview(traits: .sizeThatFitsLayout) {
    ContentView(books: Book.sampleBooks)
}

struct ExtractedView: View {
    var book: Book
    var body: some View {
        HStack {
            Image(book.mediumCoverImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 90)
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text("by \(book.author)")
                    .font(.subheadline)
                Text("\(book.pages) pages")
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}
