//
//  removedBinaryMultiarrayToBackgroundRemovedPNG.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation
import UIKit

func removedBinaryMultiarrayToBackgroundRemovedPNG(_ ma: [[UIColor]], _ rbm: [[Int]]) throws -> Data {
	// ma stands for Multiarray, rbm stands for RemovedBinaryMultiarray
	// Create an empty image of the correct size.
	let rows = ma.count
	let columns = ma[0].count
	
	let width = rbm.count
	let height = rbm[0].count
	
	var left = -1
	var right = -1
	var up = -1
	var down = -1
	
	for x in 0..<width {
		var breakChecker = false
		for y in 0..<height {
			if rbm[x][y] != 2 {
				left = x
				breakChecker = true
				break
			}
		}
		if breakChecker {
			break
		}
	}
	
	for x in (0..<width).reversed() {
		var breakChecker = false
		for y in 0..<height {
			if rbm[x][y] != 2 {
				right = x
				breakChecker = true
				break
			}
		}
		if breakChecker {
			break
		}
	}
	
	for y in 0..<height {
		var breakChecker = false
		for x in 0..<width {
			if rbm[x][y] != 2 {
				up = y
				breakChecker = true
				break
			}
		}
		if breakChecker {
			break
		}
		
	}
	
	for y in (0..<height).reversed() {
		var breakChecker = false
		for x in 0..<width {
			if rbm[x][y] != 2 {
				down = y
				breakChecker = true
				break
			}
		}
		if breakChecker {
			break
		}
		
	}
	
	let size = CGSize(width: down - up + 1, height: right - left + 1)
	UIGraphicsBeginImageContextWithOptions(size, true, 0)
	//	let size = CGSize(width: columns, height: rows)
	//	UIGraphicsBeginImageContextWithOptions(size, true, 0)
	
	
	// Fill the image with the corresponding colors.
	for x in left...right {
		for y in up...down {
			var color = ma[x][y]
			if rbm[x][y] == 2 {
				color = UIColor.clear
			}
			color.setFill()
			let rect = CGRect(x: y - up, y: -x + right, width: 1, height: 1) // 왠지 몰라도 결과물이 뒤집혀있길래 여기서 y를 뒤집어줬음
			UIRectFill(rect)
		}
	}
	//	for row in 0..<rows {
	//		for column in 0..<columns {
	//			var color = ma[row][column]
	//			if rbm[row][column] == 2 {
	//				color = UIColor.clear
	//			}
	//			color.setFill()
	//			let rect = CGRect(x: column, y: rows - 1 - row, width: 1, height: 1) // 왠지 몰라도 결과물이 뒤집혀있길래 여기서 y를 뒤집어줬음
	//			UIRectFill(rect)
	//		}
	//	}
	
	
	
	// Extract the UIImage from the graphics context.
	guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
		throw NSError(domain: "ImageError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to get UIImage from current context"])
	}
	
	// End the graphics context.
	UIGraphicsEndImageContext()
	
	// Convert the UIImage to PNG data and save it to the specified URL.
	guard let data = image.pngData() else {
		throw NSError(domain: "ImageError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to get PNG data from UIImage"])
	}
	
	return data
}
