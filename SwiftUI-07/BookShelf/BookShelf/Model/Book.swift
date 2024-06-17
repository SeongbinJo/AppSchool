//
//  Book.swift
//  BookShelf
//
//  Created by 조성빈 on 6/17/24.
//

import Foundation

struct Book {
    var title: String
    var author: String
    var isbn: String
    var pages: Int
}

extension Book {
    var smallCoverImage: String { return "\(isbn)-S" }
    var mediumCoverImage: String { return "\(isbn)-M" }
    var LargeCoverImage: String { return "\(isbn)-L" }
}

extension Book {
    static let sampleBooks = [
        Book(title: "Changer", author: "Matt Gemmell", isbn: "9781916265202", pages: 476),
        Book(title: "SwiftUI for Absolute Beginners", author: "Jayant Varma", isbn: "9781484255155", pages: 200),
        Book(title: "Asynchronous Programming with SwiftUI and Combine", author: "Peter Friese", isbn: "9781484285718", pages: 367),
        Book(title: "Modern Concurrency on Apple Platforms", author: "Andy Ibanez", isbn: "9781484286944", pages: 368)
    ]
}
