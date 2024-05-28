//
//  AddJournalEntryView.swift
//  JRNL-SwiftUI_With_AppSchool
//
//  Created by 조성빈 on 5/28/24.
//

import SwiftUI

struct AddJournalEntryView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var isGetLocation: Bool = false
    @State private var title: String = ""
    @State private var entryBody: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Rating")) {
                    Rectangle()
                        .foregroundStyle(.cyan)
                }
                Section(header: Text("Location")) {
                    Toggle("Get Location", isOn: $isGetLocation)
                }
                Section(header: Text("Title")) {
                    TextField(text: $title) {
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
                        Button(action: {}) {
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
