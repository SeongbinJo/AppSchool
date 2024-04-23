//
//  SecondTabView.swift
//  LifeCycleDemo
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

struct SecondTabView: View {
    
    @State var text: String = ""
    
    var body: some View {
        TextEditor(text: $text)
            .padding()
            .onChange(of: text) { oldValue, newValue in
                print("onChange triggered \(oldValue) : \(newValue)")
            }
    }
}

#Preview {
    SecondTabView()
}
