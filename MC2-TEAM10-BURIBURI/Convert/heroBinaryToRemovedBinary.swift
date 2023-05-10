//
//  heroBinaryToRemovedBinary.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation

func heroBinaryToRemovedBinary(_ input: [[Int]]) -> [[Int]] {
	var width: Int {
		input.count
	}
	var height: Int {
		input[0].count
	}
	
	var temp = input
	
	for x in [0, width - 1] {
		for y in 0..<height {
			if temp[x][y] == 1 {
				temp[x][y] = 2
			}
		}
	}
	
	for _ in 0..<3 {
		horizontalExtension()
		verticalExtension()
	}
	
	return temp
	
	func horizontalExtension() {
		for x in 0..<width {
			for y in 0..<height {
				if temp[x][y] == 2 && temp[min(x+1, width-1)][y] == 1 { // 그 점은 삭제될 배경(=2), 오른쪽 인접점은 아직 삭제 안 된 배경(=1)
					for i in 1..<width {
						if width <= x+i || temp[x+i][y] != 1 {
							break
						}
						temp[x+i][y] = 2
					}
				}
				
				if temp[x][y] == 2 && temp[max(0, x-1)][y] == 1 { // 그 점은 삭제될 배경(=2), 왼쪽 인접점은 아직 삭제 안 된 배경(=1)
					for i in 1..<width {
						if x-i < 0 || temp[x-i][y] != 1 {
							break
						}
						temp[x-i][y] = 2
					}
				}
			}
		}
	}
	
	func verticalExtension() {
		for x in 0..<width {
			for y in 0..<height {
				if temp[x][y] == 2 && temp[x][min(y+1, height-1)] == 1 { // 그 점은 삭제될 배경(=2), 아래쪽 인접점은 아직 삭제 안 된 배경(=1)
					for i in 1..<height {
						if height <= y+i || temp[x][y+i] != 1 {
							break
						}
						temp[x][y+i] = 2
					}
				}
				
				if temp[x][y] == 2 && temp[x][max(0, y-1)] == 1 { // 그 점은 삭제될 배경(=2), 위쪽 인접점은 아직 삭제 안 된 배경(=1)
					for i in 1..<height {
						if y-i < 0 || temp[x][y-i] != 1 {
							break
						}
						temp[x][y-i] = 2
					}
				}
			}
		}
	}
	
}
