//
//  ContentView.swift
//  PDF
//
//  Created by 조성빈 on 7/8/24.
//

import SwiftUI
import PDFKit

struct ContentView: View {
    let fileURL = Bundle.main.url(forResource: "example", withExtension: "pdf")
    var body: some View {
        VStack {
            ViewMe(url: fileURL!)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

struct ViewMe: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: UIViewRepresentableContext<ViewMe>) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
    }
}

// PDF 파일은 .gitigore에 추가.
