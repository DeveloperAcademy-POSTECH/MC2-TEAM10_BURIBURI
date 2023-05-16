//
//  monochromeToBinary.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation

func monochromeToBinary(_ input: [[CGFloat]], _ br: CGFloat) -> [[Int]] {
	
	let height = input.count
	let width = input[0].count
	
	var temp = Array(repeating: Array(repeating: 0, count: width), count: height)
	
	for y in 0..<height {
		for x in 0..<width {
			temp[y][x] = (br < input[y][x] ? 1 : 0)
			// 선이 0이고 선 아닌 곳이 1이다
		}
	}
	
	return temp
}
