//
//  UIImage+Extensions.swift
//  HelloML
//
//  Created by Farih Muhammad on 20/10/2025.
//

import Foundation
import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
