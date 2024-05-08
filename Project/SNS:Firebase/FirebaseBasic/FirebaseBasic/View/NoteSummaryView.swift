//
//  NoteSummaryView.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/30/24.
//

import SwiftUI

struct NoteSummaryView: View {
    var note: Note
    private let format: Date.FormatStyle = .dateTime.month(.wide).day().year()
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
                .font(.headline)
                .fontWeight(.bold)
            Text("\(note.date, format: format)")
                .font(.subheadline)
        }
    }
}

#Preview {
    List(0..<5) { item in
        NoteSummaryView(note: Note.sample)
    }
}
