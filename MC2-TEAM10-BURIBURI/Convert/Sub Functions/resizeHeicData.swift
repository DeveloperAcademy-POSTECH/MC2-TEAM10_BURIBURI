//
//  resizeHeicData.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import UIKit
import AVFoundation
import Photos
import MobileCoreServices

func resizeHeicData(heicData: Data, compressionQuality: CGFloat) -> Data {
	guard let sourceImage = UIImage(data: heicData) else {
		print("Failed to create source image")
		return Data()
	}
	
	let targetSize = CGSize(width: 750, height: 1000)
	
	UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
	sourceImage.draw(in: CGRect(origin: .zero, size: targetSize))
	guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
		UIGraphicsEndImageContext()
		print("Failed to resize image")
		return Data()
	}
	UIGraphicsEndImageContext()
	
	guard let heicData = resizedImage.heicData(compressionQuality: compressionQuality) else {
		print("Failed to convert image to HEIC format")
		return Data()
	}
	
	return heicData
}
