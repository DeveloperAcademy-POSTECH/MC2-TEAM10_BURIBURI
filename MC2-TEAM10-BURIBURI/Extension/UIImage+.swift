//
//  UIImage+.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation
import UIKit
import AVFoundation
import MobileCoreServices

extension UIImage {
	func heicData(compressionQuality: CGFloat) -> Data? {
		guard let data = self.jpegData(compressionQuality: compressionQuality) else {
			return nil
		}
		
		let heicData = NSMutableData()
		guard let destination = CGImageDestinationCreateWithData(heicData, kUTTypeJPEG, 1, nil) else {
			return nil
		}
		
		CGImageDestinationAddImage(destination, self.cgImage!, nil)
		CGImageDestinationFinalize(destination)
		
		return heicData as Data
	}
}

extension UIImage {
	func flipHorizontally() -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		guard let context = UIGraphicsGetCurrentContext() else {
			return nil
		}
		
		context.translateBy(x: size.width, y: 0)
		context.scaleBy(x: -1, y: 1)
		
		draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
		
		let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return flippedImage
	}
}
