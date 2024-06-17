//
//  BookDetailView.swift
//  BookShelf
//
//  Created by 조성빈 on 6/17/24.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var book: Book
    @State var showEditBookView = false
    
    var body: some View {
        Form {
            Text(book.title)
            Image(book.largeCoverImageName)
                .resizable()
                .scaledToFit()
                .shadow(radius: 10)
                .onAppear()
            Label(book.author, systemImage: "person.crop.rectangle")
            Label("ISBN: \(book.isbn)", systemImage: "number")
            Label("\(book.pages) pages", systemImage: "book")
            Toggle("Read", isOn: .constant(book.isRead))
            Button(action: {
                showEditBookView.toggle()
            }) {
                Label("Edit", systemImage: "pencil")
            }
        }
        .navigationTitle(book.title)
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: .constant(Book.sampleBooks[0]))
    }
}
