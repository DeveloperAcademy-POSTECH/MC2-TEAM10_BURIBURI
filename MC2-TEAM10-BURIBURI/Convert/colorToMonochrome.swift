//
//  colorToMonochrome.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation
import UIKit

func colorToMonochrome(_ input: [[UIColor]]) -> [[CGFloat]]{

	let width = input.count
	let height = input[0].count

	var temp = Array(repeating: Array(repeating: CGFloat(0.0), count: height), count: width)
	
	for x in 0..<width {
		for y in 0..<height {
			
			var red: CGFloat = 0
			var green: CGFloat = 0
			var blue: CGFloat = 0
			
			input[x][y].getRed(&red, green: &green, blue: &blue, alpha: nil)
			
			let brightness = (red + green + blue) / 3
			
			temp[x][y] = brightness
		}
		
	}
	
	return temp
}
