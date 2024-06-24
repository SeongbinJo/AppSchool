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
    
    init() {
        $result.compactMap { $0.definitions }
            .assign(to: &$definitions)
    }
    
    private func buildURLRequest(for searchTerm: String) -> URLRequest {
        let escapedSearchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let url = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(escapedSearchTerm)/definitions")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(WordsAPISecrets.apiKey, forHTTPHeaderField: WordsAPISecrets.apiKeyHeader)
        request.setValue(WordsAPISecrets.apiHost, forHTTPHeaderField: WordsAPISecrets.apiHostHeader)
        return request
    }
    
    @MainActor
    func executeQuery(for searchTerm: String) async {
        isSearching = true
        result = await search(for: searchTerm)
        isSearching = false
    }
    
    
    private func search(for searchTerm: String) async -> Word {
        let request = buildURLRequest(for: searchTerm)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                throw WordsAPIError.invalidServerResponse
            }
            let word = try JSONDecoder().decode(Word.self, from: data)
            return word
        } catch {
            return Word.empty
        }
    }
}
