//
//  LibraryViewModel.swift
//  WordBrowser
//
//  Created by 조성빈 on 6/24/24.
//

import Foundation

class LibraryViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var randomWord: String = "apple"
    @Published var tips: [String] = ["Swift", "authentication", "authorization"]
    @Published var favorites: [String] = ["stunning", "billiant", "marvelous"]
    
    @Published var filteredTips: [String] = []
    @Published var filteredFavorites: [String] = []
}
