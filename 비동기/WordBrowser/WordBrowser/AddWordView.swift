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
                .autocorrectionDisabled()
        }
        .navigationTitle("Add New")
        .onSubmit(handleOnAddWord)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Done", action: handleOnAddWord)
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
//        AddWordView(onAddWord:  { word in
//            print(word)
//        })
        AddWordView { word in
            print(word)
        }
    }
}
