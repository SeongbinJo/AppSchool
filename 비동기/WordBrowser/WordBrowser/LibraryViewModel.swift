//
//  LibraryViewModel.swift
//  WordBrowser
//
//  Created by 조성빈 on 6/24/24.
//

import Foundation
import Combine

class LibraryViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var randomWord: String = "apple"
    @Published var tips: [String] = ["Swift", "authentication", "authorization"]
    @Published var favorites: [String] = ["stunning", "billiant", "marvelous"]
    
    @Published var filteredTips: [String] = []
    @Published var filteredFavorites: [String] = []
    
    init() {
        Publishers.CombineLatest($searchText, $tips)
            .map { query, items in
                items.filter { item in
                    query.isEmpty ? true : item.contains(query)
                }
            }
            .assign(to: &$filteredTips)
        
        Publishers.CombineLatest($searchText, $favorites)
            .map { query, items in
                items.filter { item in
                    query.isEmpty ? true : item.contains(query)
                }
            }
            .assign(to: &$filteredFavorites)
    }
    
    private func buildURLRequest() -> URLRequest {
        let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(WordsAPISecrets.apiKey, forHTTPHeaderField: WordsAPISecrets.apiKeyHeader)
        request.setValue(WordsAPISecrets.apiHost, forHTTPHeaderField: WordsAPISecrets.apiHostHeader)
        return request
    }
    
    private func fetchRandomWord() async -> Word {
        let request = buildURLRequest()
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw WordsAPIError.invalidServerResponse
            }
            let word = try JSONDecoder().decode(Word.self, from: data)
            return word
        } catch {
            return Word.empty
        }
    }
    
    
    func refresh() async {
        let result = await fetchRandomWord()
        randomWord = result.word
    }
    
    func addFavorite(_ word: String) {
        favorites.append(word)
    }
}
