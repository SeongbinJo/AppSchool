//
//  JournalListView.swift
//  JRNL-SwiftUI_With_AppSchool
//
//  Created by 조성빈 on 5/28/24.
//

import SwiftUI
import SwiftData

struct JournalListView: View {
    @State private var isShowAddJournalView: Bool = false
    @Query(sort:\JournalEntry.date) var journalEntries: [JournalEntry]
    
    var body: some View {
        NavigationStack {
            List(journalEntries) { journalEntry in
                Text(journalEntry.entryTitle)
            }
            .listStyle(.plain)
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowAddJournalView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isShowAddJournalView) {
                        AddJournalEntryView()
                    }
                }
            }
        }
    }
}

#Preview {
    JournalListView()
        .modelContainer(for: JournalEntry.self, inMemory: true) // inmemory true해줘야 프리뷰 오류 안 ㄴ마.
}
