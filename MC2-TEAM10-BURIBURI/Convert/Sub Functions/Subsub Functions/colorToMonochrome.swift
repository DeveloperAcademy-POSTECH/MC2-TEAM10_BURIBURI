//
//  colorToMonochrome.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation
import UIKit

func colorToMonochrome(_ input: [[UIColor]]) -> [[CGFloat]]{

	let height = input.count
	let width = input[0].count

	var temp = Array(repeating: Array(repeating: CGFloat(0.0), count: width), count: height)
	
	for y in 0..<height {
		for x in 0..<width {
			
			var red: CGFloat = 0
			var green: CGFloat = 0
			var blue: CGFloat = 0
			
			input[y][x].getRed(&red, green: &green, blue: &blue, alpha: nil)
			
			let brightness = (red + green + blue) / 3
			
			temp[y][x] = brightness
		}
		
	}
	
	return temp
}
