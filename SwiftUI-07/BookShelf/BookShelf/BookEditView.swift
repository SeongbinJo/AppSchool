//
//  BookEditView.swift
//  BookShelf
//
//  Created by 조성빈 on 6/18/24.
//

import SwiftUI

struct BookEditView: View {
    @Binding var book: Book
    
    var body: some View {
        Form {
            TextField("Book title", text: $book.title)
            Image(book.largeCoverImageName)
            TextField("Author", text: $book.author)
            TextField("Pages", value: $book.pages, formatter: NumberFormatter())
            Toggle("Read", isOn: $book.isRead)
            
        }
    }
}

#Preview {
    BookEditView(book: .constant(Book.sampleBooks[0]))
}
