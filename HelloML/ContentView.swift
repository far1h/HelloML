//
//  ContentView.swift
//  HelloML
//
//  Created by Farih Muhammad on 20/10/2025.
//

import SwiftUI
import CoreML

struct ProbabilityListView: View {
    let probs: [Dictionary<String, Double>.Element]
    
    var body: some View {
        List {
            ForEach(probs, id: \.key) { key, value in
                HStack {
                    Text(key)
                    Spacer()
                    Text(String(format: "%.2f%%", value * 100))
                }
            }
        }.listStyle(.plain)
    }
}


struct ContentView: View {
    
    let images = ["1", "2", "3"]
    let model = try! MobileNetV2(configuration: MLModelConfiguration())
    
    @State private var probs: [String: Double] = [:]
    @State private var currentIndex = 0
    
    private var sortedProbs: [Dictionary<String, Double>.Element] {
        return probs.sorted { $0.value > $1.value }
    }
    
    var body: some View {
        VStack {
            Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            
            HStack {
                Button("Previous") {
                    currentIndex = currentIndex - 1
                }.disabled(currentIndex == 0)
                Button("Next") {
                    currentIndex = currentIndex + 1
                }.disabled(currentIndex == images.count - 1)
                
            }.buttonStyle(.bordered)
            Button("Predict") {
                guard let uiImage = UIImage(named: images[currentIndex]) else {
                    print("Image not found")
                    return
                }
                let resizedImage = uiImage.resized(to: CGSize(width: 224, height: 224))
                guard let buffer = resizedImage.toCVPixelBuffer() else {
                    return
                }
                do {
                    let prediction = try model.prediction(image: buffer)
                    probs = prediction.classLabelProbs
                } catch {
                    print("Error during prediction: \(error)")
                }
            }.buttonStyle(.borderedProminent)
            ProbabilityListView(probs: sortedProbs)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
