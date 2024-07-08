//
//  ContentView.swift
//  TextToSpeech
//
//  Created by 조성빈 on 7/8/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let audio = AVSpeechSynthesizer()
    
    @State var convertText = AVSpeechUtterance(string: "")
    @State var textToRoad = "This is a test of the emergency broadcast system"
    @State var sliderValue: Float = 0.0
    
    var body: some View {
        VStack {
            TextEditor(text: $textToRoad)
                .frame(width:250, height: 200)
            Slider(value: $sliderValue, in:0...1)
            Button {
                convertText = AVSpeechUtterance(string: textToRoad)
                convertText.rate = sliderValue
                audio.speak(convertText)
            } label: {
                Text("Read Text Out Loud")
            }
        }
    }
}

#Preview {
    ContentView()
}
