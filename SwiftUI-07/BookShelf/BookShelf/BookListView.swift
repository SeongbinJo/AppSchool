//
//  BookListView.swift
//  BookShelf
//
//  Created by 조성빈 on 6/17/24.
//

import SwiftUI

struct BookListView: View {
    var books: [Book] = Book.sampleBooks
    
    var body: some View {
        List(books, id: \.title) { book in
            BookRowView(book: book)
        }
        .listStyle(.plain)
    }
}

#Preview {
    BookListView()
}
