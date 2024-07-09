//
//  ContentView.swift
//  FaceRecognition
//
//  Created by 조성빈 on 7/9/24.
//
import SwiftUI
import Vision

struct ContentView: View {
    
    let photoArray =  ["image1", "image2", "image3"]
    
    @State var message = ""
    @State var arrayIndex = 0
    @State var analyzedImage: UIImage?

    var body: some View {
        VStack {
            if let image = analyzedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 500)
            } else {
                Image(photoArray[arrayIndex])
                    .resizable()
                    .blur(radius: 5)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 500)
            }
            Text(message)
                .padding()
            Button {
                analyzeImage(image: UIImage(named: photoArray[arrayIndex])!)
            } label: {
                Text("Analyze Image")
            }.padding()

            HStack {
                Spacer()
                Button {
                    if arrayIndex == 0 {
                        arrayIndex = photoArray.count - 1
                    } else {
                        arrayIndex -= 1
                    }
                    message = ""
                    analyzedImage = nil
                } label: {
                    Image(systemName: "chevron.left.square.fill")
                        .font(.largeTitle)
                }
                Spacer()
                Button {
                    if arrayIndex == photoArray.count - 1 {
                        arrayIndex = 0
                    } else {
                        arrayIndex += 1
                    }
                    message = ""
                    analyzedImage = nil
                } label: {
                    Image(systemName: "chevron.right.square.fill")
                        .font(.largeTitle)
                }
                Spacer()
            }
        }
        .padding()
    }
    
    func analyzeImage(image: UIImage) {
        let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNDetectFaceLandmarksRequest(completionHandler: handleFaceRecognition)
        try! handler.perform([request])
    }
    
    func handleFaceRecognition(request: VNRequest, error: Error?) {
        guard let foundFaces = request.results as? [VNFaceObservation] else {
            fatalError("Can't find a face in the picture")
        }
        message = "Found \(foundFaces.count) faces in the picture"
        
        guard let image = UIImage(named: photoArray[arrayIndex]) else { return }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()!
                
        image.draw(in: CGRect(origin: .zero, size: image.size))
        
        // 이미지를 그린 후 좌표계를 변환합니다.
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(5)

        for faceObservation in foundFaces {
            let faceRect = VNImageRectForNormalizedRect(faceObservation.boundingBox, Int(image.size.width), Int(image.size.height))
            context.stroke(faceRect)
        }
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        analyzedImage = newImage
    }
}

#Preview {
    ContentView()
}
