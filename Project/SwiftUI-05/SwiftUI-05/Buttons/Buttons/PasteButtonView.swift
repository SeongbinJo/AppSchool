//
//  PasteButtonView.swift
//  Buttons
//
//  Created by 조성빈 on 4/23/24.
//

import SwiftUI

struct PasteButtonView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Text(text)
            PasteButton(payloadType: String.self) { string in
                guard let string = string.first else {
                    return
                }
                text = string
            }
            .buttonBorderShape(.capsule)
            .labelStyle(.iconOnly)
            .tint(.red)
        }
    }
}

#Preview {
    NavigationStack {
        PasteButtonView()
    }
}
