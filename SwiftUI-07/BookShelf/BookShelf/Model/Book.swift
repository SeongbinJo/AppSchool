//
//  Book.swift
//  BookShelf
//
//  Created by 조성빈 on 6/17/24.
//

import Foundation

struct Book: Identifiable {
    var id: String { return isbn }
    var title: String
    var author: String
    var isbn: String
    var pages: Int
    var isRead: Bool
}

extension Book {
    var smallCoverImageName: String { return "\(isbn)-S" }
    var mediumCoverImageName: String { return "\(isbn)-M" }
    var largeCoverImageName: String { return "\(isbn)-L" }
}

extension Book {
    static let sampleBooks = [
        Book(title: "Changer", author: "Matt Gemmell",
             isbn: "9781916265202", pages: 476, isRead: false),
        Book(title: "SwiftUI for Absolute Beginners", author: "Jayant Varma",
             isbn: "9781484255155", pages: 200, isRead: true),
        Book(title: "Asynchronous Programming with SwiftUI and Combine", author: "Peter Friese",
             isbn: "9781484285718", pages: 367, isRead: true),
        Book(title: "Modern Concurrency on Apple Platforms", author: "Andy Ibanez",
             isbn: "9781484286944", pages: 368, isRead: false)
    ]
}
