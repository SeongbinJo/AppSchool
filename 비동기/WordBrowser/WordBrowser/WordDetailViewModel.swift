//
//  WordDetailViewModel.swift
//  WordBrowser
//
//  Created by 조성빈 on 6/24/24.
//

import Foundation
import Combine

class WordDetailViewModel: ObservableObject {
    @Published private var result = Word.empty
    @Published var isSearching = false
    @Published var definitions = [Definition]()
    
    
}
