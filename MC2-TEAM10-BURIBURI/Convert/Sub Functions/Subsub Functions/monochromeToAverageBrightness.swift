//
//  monochromeToAverageBrightness.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation

func monochromeToAverageBrightness(_ input: [[CGFloat]]) -> CGFloat {
	let height = input.count
	let width = input[0].count
	
	let yResolution = 100
	let xResolution = 100
	
	var temp: CGFloat = 0.0
	
	for x in 0..<xResolution {
		for y in 0..<yResolution {
			temp += input[min(height / yResolution * y, height - 1)][min(width / xResolution * x, width - 1)]
		}
	}
	
	temp /= CGFloat(xResolution * yResolution)
	
	return temp

}
