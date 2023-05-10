//
//  resizeHeicImage.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import UIKit
import AVFoundation
import Photos

func resizeHeicImage(at sourceURL: URL, with size: CGSize, compressionQuality: CGFloat) throws -> Data {
	// Load source image
	let sourceData = try Data(contentsOf: sourceURL)
	guard let sourceImage = UIImage(data: sourceData) else {
		throw NSError(domain: "Invalid image data", code: -1, userInfo: nil)
	}
	
	// Create drawing context for resized image
	let scale = UIScreen.main.scale
	UIGraphicsBeginImageContextWithOptions(size, false, scale)
	sourceImage.draw(in: CGRect(origin: .zero, size: size))
	guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
		throw NSError(domain: "Failed to resize image", code: -1, userInfo: nil)
	}
	UIGraphicsEndImageContext()
	
	// Save resized image to HEIC format
	guard let destinationData = resizedImage.heicData(compressionQuality: compressionQuality) else {
		throw NSError(domain: "Failed to convert image to HEIC format", code: -1, userInfo: nil)
	}
	return destinationData
}

