//
//  PasteButtonView.swift
//  Buttons
//
//  Created by Jungman Bae on 4/23/24.
//

import SwiftUI

struct PasteButtonView: View {
    @State var text = ""
    var body: some View {
        VStack {
            Text(text)
            PasteButton(payloadType: String.self) { strings in
                guard let string = strings.first else {
                    return
                }
                text = string
            }
            .buttonBorderShape(.capsule)
            .labelStyle(.iconOnly)
            .tint(.red)
        }
        .navigationTitle("PasteButton View")
    }
}

#Preview {
    NavigationStack {
        PasteButtonView()
    }
}
