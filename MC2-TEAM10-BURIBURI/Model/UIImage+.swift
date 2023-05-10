//
//  UIImage+.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation
import UIKit
import AVFoundation

extension UIImage {
	func heicData(compressionQuality: CGFloat) -> Data? {
		guard let cgImage = self.cgImage else {
			return nil
		}

		let width = Int(self.size.width)
		let height = Int(self.size.height)

		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

		guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
			return nil
		}

		context.draw(cgImage, in: CGRect(origin: .zero, size: self.size))

		guard let destinationData = CFDataCreateMutable(kCFAllocatorDefault, 0) else {
			return nil
		}

		guard let destination = CGImageDestinationCreateWithData(destinationData, AVFileType.heic as CFString, 1, nil) else {
			return nil
		}

		let options = [
			kCGImageDestinationLossyCompressionQuality as String: compressionQuality
		] as CFDictionary

		CGImageDestinationAddImage(destination, context.makeImage()!, options)

		if !CGImageDestinationFinalize(destination) {
			return nil
		}

		return destinationData as Data
	}
}
