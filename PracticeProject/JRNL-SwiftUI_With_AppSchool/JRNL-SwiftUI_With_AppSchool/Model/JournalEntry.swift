//
//  JournalEntry.swift
//  JRNL-SwiftUI_With_AppSchool
//
//  Created by 조성빈 on 5/28/24.
//

import UIKit
import SwiftData

@Model
class JournalEntry {
    let date: Date
    let rating: Int
    let entryTitle: String
    let entryBody: String
    @Attribute(.externalStorage) let photoData: Data?
    let latitude: Double?
    let longitude: Double?
    
    init(rating: Int, entryTitle: String, entryBody: String, photo: UIImage?, latitude: Double?, longitude: Double?) {
        self.date = Date()
        self.rating = rating
        self.entryTitle = entryTitle
        self.entryBody = entryBody
        self.photoData = photo?.jpegData(compressionQuality: 0.1)
        self.latitude = latitude
        self.longitude = longitude
    }
    
    @Transient
    var photo: UIImage? {
            if let data = photoData {
                return UIImage(data: data)
            }
            return nil
        }
}
