//
//  ContentView.swift
//  Language
//
//  Created by 조성빈 on 7/9/24.
//

import SwiftUI
import NaturalLanguage

struct ContentView: View {
    
    @State var language = ""
    @State var message = ""
    
    var body: some View {
        VStack {
            TextField("Type foreign text here", text: $language)
                .autocorrectionDisabled()
                .padding()
            Text("Language = \(message)")
                .padding()
            Button {
                if let prediction = predictLanguage(text: language) {
                    message = prediction
                }
            } label: {
                Text("Identify Language")
            }
        }
        .padding()
    }
    
    func predictLanguage(text: String) -> String? {
        let locale = Locale(identifier: "en")
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(text)
        guard let language = recognizer.dominantLanguage else {
            return "Unknown language"
        }
        return locale.localizedString(forIdentifier: language.rawValue)
    }
}

#Preview {
    ContentView()
}
