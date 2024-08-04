//
//  UIImage+Extension.swift
//  Jujamanru
//
//  Created by 영현 on 8/4/24.
//

import UIKit

extension UIImage {
    func compressedData(maxSizeMB: Double) -> Data? {
        let maxSizeBytes = maxSizeMB * 1024 * 1024
        var compression: CGFloat = 1.0
        var imageData = self.jpegData(compressionQuality: compression)
        
        while let data = imageData, Double(data.count) > maxSizeBytes, compression > 0.1 {
            compression -= 0.1
            imageData = self.jpegData(compressionQuality: compression)
        }
        
        return imageData
    }
}

