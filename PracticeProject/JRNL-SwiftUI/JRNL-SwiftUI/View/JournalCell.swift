//
//  JournalCell.swift
//  JRNL-SwiftUI
//
//  Created by 조성빈 on 5/28/24.
//

import SwiftUI

struct JournalCell: View {
//    let journalEntry: JournalEntry
    
    var body: some View {
        HStack {
            // 이미지
            Image(systemName: "face.smiling")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                // 날짜
                Text("2022.05.12")
                // 제목
                Text("Test Title")
            }
            Spacer()
        }
        .padding(.horizontal, 30)

    }
}

#Preview {
    JournalCell()
}
