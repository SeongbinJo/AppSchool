//
//  JournalEntry.swift
//  JRNL-SwiftUI_With_AppSchool
//
//  Created by 조성빈 on 5/28/24.
//

import Foundation
import SwiftData

@Model
class JournalEntry {
    let date: Date
    let rating: Int
    let entryTitle: String
    let entryBody: String
    let latitude: Double?
    let longitude: Double?
    
    init(rating: Int, entryTitle: String, entryBody: String, latitude: Double?, longitude: Double?) {
        self.date = Date()
        self.rating = rating
        self.entryTitle = entryTitle
        self.entryBody = entryBody
        self.latitude = latitude
        self.longitude = longitude
    }
}
