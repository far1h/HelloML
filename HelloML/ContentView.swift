//
//  ContentView.swift
//  HelloML
//
//  Created by Farih Muhammad on 20/10/2025.
//

import SwiftUI

struct ContentView: View {
    
    let images = ["1", "2", "3"]
    @State private var currentIndex = 0
    
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
                
                
            }.buttonStyle(.borderedProminent)
            
            List {
                Text("Prediction 1")
                Text("Prediction 2")
                Text("Prediction 3")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
