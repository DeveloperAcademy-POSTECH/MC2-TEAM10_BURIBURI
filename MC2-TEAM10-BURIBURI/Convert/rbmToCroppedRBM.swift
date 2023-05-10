//
//  rbmToCroppedRBM.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/10.
//

import Foundation

func rbmToCroppedRBM(_ rbm: [[Int]]) -> [[Int]] {
	
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
	
	var tbr = Array(repeating: Array(repeating: 0, count: down-up+1), count: right-left+1)
	
	for x in left...right {
		for y in up...down {
			tbr[x-left][y-up] = rbm[x][y]
			
		}
	}
	
	return tbr
}
