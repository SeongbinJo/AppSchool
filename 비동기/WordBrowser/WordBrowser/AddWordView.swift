//
//  AddWordView.swift
//  WordBrowser
//
//  Created by 조성빈 on 6/24/24.
//

import SwiftUI

struct AddWordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var word: String = ""
    
    var onAddWord: (String) -> Void
    
    var body: some View {
        Form {
            TextField("Word", text: $word)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled() // 자동완성 끔
        }
        .navigationTitle("Add New")
        .onSubmit(handleOnAddWord)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(action: {
                    dismiss()
                }) {
                    
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    handleOnAddWord()
                }) {
                    Text("Done")
                }
                .disabled(word.isEmpty)
            }
        }
    }
    
    
    private func handleOnAddWord() {
        onAddWord(word)
        dismiss()
    }
    
}

#Preview {
    NavigationStack {
        AddWordView { word in
            
        }
    }
}
