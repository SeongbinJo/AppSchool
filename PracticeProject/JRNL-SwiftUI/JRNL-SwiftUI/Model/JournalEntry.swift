//
//  JournalEntry.swift
//  JRNL-SwiftUI
//
//  Created by 조성빈 on 5/28/24.
//

import UIKit
import SwiftData

@Model
class JournalEntry {
    let dateString: String
    let rating: Int
    let entryTitle: String
    let entryBody: String
    let photoData: Data?
    let latitude: Double?
    let longitude: Double?
    
    // MARK: - Intialization
    init?(rating: Int, title: String, body: String,
          photo: UIImage? = nil, latitude: Double? = nil, longitude: Double? = nil) {
        if title.isEmpty || body.isEmpty || rating < 0 || rating > 5 {
            return nil
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        self.dateString = formatter.string(from: Date())
        self.rating = rating
        self.entryTitle = title
        self.entryBody = body
        self.photoData = photo?.jpegData(compressionQuality: 1.0)
        self.latitude = latitude
        self.longitude = longitude
    }
}
