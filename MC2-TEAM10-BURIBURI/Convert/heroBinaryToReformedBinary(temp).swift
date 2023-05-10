//
//  heroBinaryToReformedBinary.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/10.
//

import Foundation

func heroBinaryToReformedBinary(_ input: [[Int]]) -> [[Int]]{
	
	let width = input.count
	let height = input[0].count
	
	var left = -1
	var right = -1
	var up = -1
	var down = -1
	
	for x in 0..<width {
		var breakChecker = false
		for y in 0..<height {
			if input[x][y] == 0 {
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
			if input[x][y] == 0 {
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
			if input[x][y] == 0 {
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
			if input[x][y] == 0 {
				down = y
				breakChecker = true
				break
			}
		}
		if breakChecker {
			break
		}
		
	}
	
	print("left: \(left)")
	print("right: \(right)")
	print("up: \(up)")
	print("down: \(down)")
	
	guard left >= 0 && right >= left && up >= 0 && down >= up else {
		return input
	}
	
	var toBeReturned = Array(repeating: Array(repeating: 1, count: down - up + 1), count: right - left + 1)
	
	for x in left..<right {
		for y in up..<down {
			toBeReturned[x - left][y - up] = input[x][y]
		}
	}
	
	return toBeReturned
}


