//
//  JournalEntry.swift
//  JRNL
//
//  Created by Jungman Bae on 5/10/24.
//

import UIKit
import MapKit
import SwiftData

@Model
class JournalEntry {
    // MARK: - Properties
    let dateString: String
    let rating: Int
    let entryTitle: String
    let entryBody: String
    @Attribute(.externalStorage) let photoData: Data?
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
