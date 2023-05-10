//
//  monochromeToBinary.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation

func monochromeToBinary(_ input: [[CGFloat]], _ br: CGFloat) -> [[Int]] {
	
	let width = input.count
	let height = input[0].count
	
	var temp = Array(repeating: Array(repeating: 0, count: height), count: width)
	
	for x in 0..<width {
		for y in 0..<height {
			temp[x][y] = (br < input[x][y] ? 1 : 0)
			// 선이 0이고 선 아닌 곳이 1이다
		}
	}
	
	return temp
}
