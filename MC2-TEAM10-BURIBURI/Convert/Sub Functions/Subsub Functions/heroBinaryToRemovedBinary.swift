//
//  heroBinaryToRemovedBinary.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation

func heroBinaryToRemovedBinary(_ input: [[Int]]) -> [[Int]] {

	let height = input.count
	let width = input[0].count
	
	var temp = input
	
	for y in [0, height - 1] {
		for x in 0..<width {
			if temp[y][x] == 1 {
				temp[y][x] = 2
			}
		}
	}
	
	for _ in 0..<3 {
		horizontalExtension()
		verticalExtension()
	}
	
	return temp
	
	func horizontalExtension() {
		for y in 0..<height {
			for x in 0..<width {
				if temp[y][x] == 2 && temp[min(y+1, height-1)][x] == 1 { // 그 점은 삭제될 배경(=2), 위쪽 인접점은 아직 삭제 안 된 배경(=1)
					for i in 1..<height {
						if height <= y+i || temp[y+i][x] != 1 {
							break
						}
						temp[y+i][x] = 2
					}
				}
				
				if temp[y][x] == 2 && temp[max(0, y-1)][x] == 1 { // 그 점은 삭제될 배경(=2), 위쪽 인접점은 아직 삭제 안 된 배경(=1)
					for i in 1..<height {
						if y-i < 0 || temp[y-i][x] != 1 {
							break
						}
						temp[y-i][x] = 2
					}
				}
			}
		}
	}
	
	func verticalExtension() {
		for y in 0..<height {
			for x in 0..<width {
				if temp[y][x] == 2 && temp[y][min(x+1, width-1)] == 1 { // 그 점은 삭제될 배경(=2), 오른쪽 인접점은 아직 삭제 안 된 배경(=1)
					for i in 1..<width {
						if width <= x+i || temp[y][x+i] != 1 {
							break
						}
						temp[y][x+i] = 2
					}
				}
				
				if temp[y][x] == 2 && temp[y][max(0, x-1)] == 1 { // 그 점은 삭제될 배경(=2), 왼쪽 인접점은 아직 삭제 안 된 배경(=1)
					for i in 1..<width {
						if x-i < 0 || temp[y][x-i] != 1 {
							break
						}
						temp[y][x-i] = 2
					}
				}
			}
		}
	}
	
}
