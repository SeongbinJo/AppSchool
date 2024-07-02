//
//  ContentView.swift
//  ReadWrite
//
//  Created by 조성빈 on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    let placeHolder = "텍스트를 입력하세요."
    @State var createText = ""
    @State var displayText = ""
    
    @FocusState var textFieldFocus: Bool
        var body: some View {
            VStack {
                TextEditor(text: $createText)
                    .foregroundStyle(placeHolder == createText ? .gray : .black)
                    .focused($textFieldFocus)
                    .onChange(of: textFieldFocus) {
                        if textFieldFocus, placeHolder == createText {
                            createText = ""
                        } else if !textFieldFocus, createText.isEmpty {
                            createText = placeHolder
                        }
                    }
            HStack {
                Button(action: {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        try createText.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
                    } catch {
                        print("File writing error")
                    }
                }) {
                    Text("Write File")
                }
                Button(action: {
                    let fm = FileManager.default
                    let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
                    let url = urls.last?.appendingPathComponent("file.txt")
                    do {
                        let fileContent = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                        displayText = fileContent
                    } catch {
                        print("File reading error")
                    }
                }) {
                    Text("Read File")
                }
            }
        }
        .padding()
        TextEditor(text: $displayText)
    }
}

#Preview {
    ContentView()
}
