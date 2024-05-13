//
//  JournalEntry.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/13/24.
//

import UIKit

class JournalEntry {
    // MARK: - Properties
    let date: Date
    let rating: Int
    let title: String
    let body: String
    let photo: UIImage?
    let latitude: Double? // 위도
    let longitude: Double? // 경도
    
    // MARK: - Initialization
    init?(rating: Int, title: String, body: String, photo: UIImage? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        if title.isEmpty || body.isEmpty || rating < 0 || rating > 5 {
            return nil
        }
        self.date = Date()
        self.rating = rating
        self.title = title
        self.body = body
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
    }
}


struct SampleJournalEntryData {
    var journalEntries: [JournalEntry] = []
    
    mutating func createSampleJournalEntryData() {
        let photo1 = UIImage(systemName: "sun.max")
        let photo2 = UIImage(systemName: "cloud")
        let photo3 = UIImage(systemName: "cloud.sun")
        guard let journalEntry1 = JournalEntry(rating: 5, title: "Good", body: "Today is good day", photo: photo1) else {
            fatalError("Unable to instantiate journalEntry1")
        }
        guard let journalEntry2 = JournalEntry(rating: 0, title: "Bad", body: "Today is bad day", photo: photo2) else {
            fatalError("Unable to instantiate journalEntry2")
        }
        guard let journalEntry3 = JournalEntry(rating: 3, title: "Ok", body: "Today is hmm.. good day", photo: photo3) else {
            fatalError("Unable to instantiate journalEntry3")
        }
        journalEntries += [journalEntry1, journalEntry2, journalEntry3]
    }
}
