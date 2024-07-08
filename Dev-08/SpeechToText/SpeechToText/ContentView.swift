//
//  ContentView.swift
//  SpeechToText
//
//  Created by 조성빈 on 7/8/24.
//

import SwiftUI
import Speech

struct ContentView: View {
    let audioEngine = AVAudioEngine()
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    
    @State var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    @State var recognitionTask: SFSpeechRecognitionTask?
    
    @State var message = ""
    @State var buttonStatus = true
    
    func startRecording() {
        message = "Start recording"
        let node = audioEngine.inputNode
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest?.shouldReportPartialResults = true
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            return print (error)
        }
        guard let recognizeMe = SFSpeechRecognizer() else {
            return
        }
        if !recognizeMe.isAvailable {
            return
        }
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest ?? SFSpeechAudioBufferRecognitionRequest.init(), resultHandler: {result, error in
            if let result = result {
                let transcribedString = result.bestTranscription.formattedString
                message = transcribedString
            } else if let error = error {
                print(error)
            }
        })
    }
    
    func stopRecording() {
        audioEngine.stop()
        recognitionTask?.cancel()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
    }
    
    var body: some View {
        VStack {
            TextEditor(text: $message)
                .frame(width: 350, height: 400)
            Button(buttonStatus ? "Start recording" : "Stop recording", action: {
                buttonStatus.toggle()
                if buttonStatus {
                    stopRecording()
                } else {
                    startRecording()
                }
            })
            .padding()
            .background(buttonStatus ? Color.green : Color.red)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
