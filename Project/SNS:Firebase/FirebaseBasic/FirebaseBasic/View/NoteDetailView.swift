//
//  NoteDetailView.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/30/24.
//

import SwiftUI

struct NoteDetailView: View {
    var note: Note
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    List(0..<5) { item in
        NoteDetailView(note: Note.sample)
    }
}
