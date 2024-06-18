//
//  BookEditView.swift
//  BookShelf
//
//  Created by 조성빈 on 6/18/24.
//

import SwiftUI

private func checkISBN(isbn: String) -> Bool {
    guard !isbn.isEmpty else {
        return false
      }
      
      let sum = isbn
        .compactMap { $0.wholeNumberValue }
        .enumerated()
        .map { $0.offset & 1 == 1 ? 3 * $0.element : $0.element }
        .reduce(0, +)
      
      return sum % 10 == 0
}

class BookEditViewModel: ObservableObject {
    @Published var book: Book
    @Published var isISBNValid: Bool = false
    
    init(book: Book) {
        self.book = book
        self.$book.map { book in
            return checkISBN(isbn: book.isbn)
        }
        .assign(to: &$isISBNValid)
    }
    
}

struct BookEditView: View {
    @Binding var book: Book
    @Environment(\.dismiss) var dismiss
    @ObservedObject var bookEditViewModel: BookEditViewModel
    init(book: Binding<Book>) {
        self._book = book
        self.bookEditViewModel = BookEditViewModel(book: book.wrappedValue)
    }
    
    func cancel() {
        dismiss()
    }
    
    func save() {
        self.book = bookEditViewModel.book
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Book title", text: $bookEditViewModel.book.title)
                Image(bookEditViewModel.book.largeCoverImageName)
                TextField("Author", text: $bookEditViewModel.book.author)
                VStack(alignment: .leading) {
                    if !bookEditViewModel.isISBNValid {
                        Text("ISBN is invalid")
                            .font(.caption)
                            .foregroundStyle(Color.red)
                    }
                    TextField("ISBN", text: $bookEditViewModel.book.isbn)
                }
                TextField("Pages", value: $bookEditViewModel.book.pages, formatter: NumberFormatter())
                Toggle("Read", isOn: $bookEditViewModel.book.isRead)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: cancel) {
                        Text("cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: save) {
                        Text("save")
                    }
                }
        }
            .navigationTitle(bookEditViewModel.book.title)
        }
    }
    
}

#Preview {
    BookEditView(book: .constant(Book.sampleBooks[0]))
}
