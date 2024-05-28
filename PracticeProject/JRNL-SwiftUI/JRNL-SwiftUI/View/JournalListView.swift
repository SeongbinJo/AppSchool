//
//  JournalListView.swift
//  JRNL-SwiftUI
//
//  Created by 조성빈 on 5/28/24.
//

import SwiftUI

struct JournalListView: View {
    @State private var isAddViewOpen: Bool = false
    @State private var isDetailViewOpen: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    List {
                        Button(action: {
                            isDetailViewOpen.toggle()
                        }) {
                            JournalCell()
                        }
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                            .navigationDestination(isPresented: $isDetailViewOpen) {
                                JournalDetailView()
                            }
                        JournalCell()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                        JournalCell()
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                    }
                    .listStyle(.plain)
                }
                .navigationTitle("Journal")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            print("add button clicked")
                            isAddViewOpen = true
                            
                        }) {
                            Image(systemName: "plus")
                        }
                        .sheet(isPresented: $isAddViewOpen) {
                            AddJournalView()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    JournalListView()
}
