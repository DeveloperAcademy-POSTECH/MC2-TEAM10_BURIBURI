//
//  heicToMultiArray.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import AVFoundation
import UIKit
import Foundation

func heicToMultiArray(_ data: Data) -> [[UIColor]] {
	guard let uiImage = UIImage(data: data) else {
		fatalError("Could not create UIImage")
	}

	guard let cgImage = uiImage.cgImage else {
		fatalError("Could not get CGImage from UIImage")
	}

	let width = cgImage.width
	let height = cgImage.height
	let bytesPerRow = cgImage.bytesPerRow

	let colorSpace = CGColorSpaceCreateDeviceRGB()
	let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
	guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
		fatalError("Could not create CGContext")
	}

	context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

	guard let pixelData = context.data else {
		fatalError("Could not get pixel data from context")
	}

	var pixelArray: [[UIColor]] = []

	for y in (0..<height).reversed() {
		var row: [UIColor] = []
		for x in 0..<width {
			let pixelOffset = (y * bytesPerRow) + (x * 4)
						let alpha = CGFloat(pixelData.load(fromByteOffset: pixelOffset, as: UInt8.self)) / 255.0
						let red = CGFloat(pixelData.load(fromByteOffset: pixelOffset + 1, as: UInt8.self)) / 255.0
						let green = CGFloat(pixelData.load(fromByteOffset: pixelOffset + 2, as: UInt8.self)) / 255.0
						let blue = CGFloat(pixelData.load(fromByteOffset: pixelOffset + 3, as: UInt8.self)) / 255.0
						
						// Change Endian
						let newBlue = CGFloat(swapInt16LittleToBig(UInt16(alpha * 65535.0))) / 65535.0
						let newGreen = CGFloat(swapInt16LittleToBig(UInt16(red * 65535.0))) / 65535.0
						let newRed = CGFloat(swapInt16LittleToBig(UInt16(green * 65535.0))) / 65535.0
						let newAlpha = CGFloat(swapInt16LittleToBig(UInt16(blue * 65535.0))) / 65535.0
						
						let color = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: newAlpha)
			row.append(color)
		}
		pixelArray.append(row)
	}

	// `pixelArray`를 사용하여 다중 배열을 초기화하거나, 원하는 방식으로 활용할 수 있습니다.

//	// 예를 들어, 다음과 같이 각 픽셀의 색 정보를 출력할 수 있습니다.
//	for row in pixelArray {
//		for color in row {
//			print(color)
//		}
//	}

//	pixelArray.reverse()
	return pixelArray
}


func swapInt16LittleToBig(_ value: UInt16) -> UInt16 {
	return (value & 0xff) << 8 | (value >> 8)
}
