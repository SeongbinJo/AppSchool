//
//  NoteList.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/30/24.
//

import SwiftUI

struct NoteListView: View {
    @State private var service: NoteServiceViewModel = NoteServiceViewModel()
    @State private var isNewNotePresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List(service.notes) { note in
                NavigationLink(value: note) {
                    NoteSummaryView(note: note)
                }
            }
            .navigationDestination(for: Note.self) { note in
                NoteDetailView(note: note)
            }
            .navigationTitle("FireNotes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: {
                    isNewNotePresented.toggle()
                }) {
                    Image(systemName: "plus")
                        .font(.headline)
                }
            }
            .sheet(isPresented: $isNewNotePresented) {
                AddNoteView(service: service)
            }
            .task {
                service.fetch()
            }
        }
    }
}

#Preview {
    NoteListView()
}
