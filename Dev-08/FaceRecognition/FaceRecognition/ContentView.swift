//
//  ContentView.swift
//  FaceRecognition
//
//  Created by 조성빈 on 7/9/24.
//
import SwiftUI
import Vision

struct ContentView: View {
    
    let photoArray =  ["image1"]
    
    @State var message = ""
    @State var arrayIndex = 0
    
    var body: some View {
        VStack {
            Image(photoArray[arrayIndex])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            Text(message)
                .padding()
            Button {
                analyzeImage(image: UIImage(named: photoArray[arrayIndex])!)
            } label: {
                Text("Analyze Image")
            }.padding()

            HStack {
                Button {
                    if arrayIndex == 0 {
                        arrayIndex = photoArray.count - 1
                    } else {
                        arrayIndex -= 1
                    }
                    message = ""
                } label: {
                    Image(systemName: "chevron.left.square.fill")
                }
                Button {
                    if arrayIndex == photoArray.count - 1 {
                        arrayIndex = 0
                    } else {
                        arrayIndex += 1
                    }
                    message = ""
                } label: {
                    Image(systemName: "chevron.right.square.fill")
                }
            }
        }
        .padding()
    }
    
    func analyzeImage(image: UIImage) {
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNDetectFaceRectanglesRequest(completionHandler: handleFaceRecognition)
        try! handler.perform([request])
    }
    
    func handleFaceRecognition(request: VNRequest, error: Error?) {
        guard let foundFaces = request.results as? [VNFaceObservation] else {
            fatalError("Can't find a face in the picture")
        }
        message = "Found \(foundFaces.count) faces in the picture"
    }
}

#Preview {
    ContentView()
}
