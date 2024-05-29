//
//  AddJournalEntryView.swift
//  JRNL-SwiftUI_With_AppSchool
//
//  Created by 조성빈 on 5/28/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            Spacer()
            ForEach(0..<5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .onTapGesture {
                        rating = index + 1
                    }
            }
            Spacer()
        }
    }
}

struct AddJournalEntryView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var rating = 0
    @State private var isGetLocation: Bool = false
    @State private var entryTitle = ""
    @State private var entryBody = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Rating")) {
                    RatingView(rating: $rating)
                }
                Section(header: Text("Location")) {
                    Toggle("Get Location", isOn: $isGetLocation)
                }
                Section(header: Text("Title")) {
                    TextField(text: $entryTitle) {
                        Text("Enter title")
                    }
                }
                Section(header: Text("Body")) {
                    TextEditor(text: $entryBody)
                }
                Section(header: Text("Photo")) {
                    Button(action: {}) {
                        Image(systemName: "face.smiling")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
            .formStyle(.automatic)
                .navigationTitle("Add Entry")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            let journalEntry = JournalEntry(rating: 3, entryTitle: entryTitle, entryBody: entryBody, latitude: nil, longitude: nil)
                            modelContext.insert(journalEntry)
                            dismiss()
                        }) {
                            Text("Save")
                                .fontWeight(.bold)
                        }
                    }
                }
        }
    }
}

#Preview {
    AddJournalEntryView()
}
