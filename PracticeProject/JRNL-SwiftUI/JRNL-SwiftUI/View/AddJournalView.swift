//
//  AddJournalView.swift
//  JRNL-SwiftUI
//
//  Created by 조성빈 on 5/28/24.
//

import SwiftUI
import PhotosUI

struct AddJournalView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isOn: Bool = false
    
    @State private var textFieldText = ""
    @State private var textEditorText = "ㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ123123"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack(spacing: 40) {
                    // 별점
                    ForEach(0..<5) {_ in 
                        Button(action: {}) {
                            Image(systemName: "star")
                        }
                    }
                }
                
                HStack(spacing: 20) {
                    // 위치 버튼
                    Toggle(isOn: $isOn) {}
                        .frame(maxWidth: 70)
                    Text("Label")
                }
                
                // 텍스트필드
                TextField(text: $textFieldText) {
                    Text("Journal Title")
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                
                // 텍스트에디터
                TextEditor(text: $textEditorText)
                    .textEditorStyle(.plain)
                    .frame(maxHeight: 200)
                    .padding(.horizontal, 30)
                
                // 이미지피커
                Button(action: {}) {
                    Image(systemName: "face.smiling")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(width: 300, height: 300)
            }
            .navigationTitle("New Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        print("Cancel button clicked.")
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("Save button clicked.")
                    }) {
                        Text("Save")
                            .fontWeight(.bold)
                    }
                    .disabled(true)
                }
            }
        }
    }
}

#Preview {
    AddJournalView()
}
