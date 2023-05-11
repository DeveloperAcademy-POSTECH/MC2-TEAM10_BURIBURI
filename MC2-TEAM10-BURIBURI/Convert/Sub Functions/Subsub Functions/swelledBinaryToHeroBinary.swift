//
//  swelledBinaryToHeroBinary.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/10.
//

import Foundation

func swelledBinaryToHeroBinary(_ input: [[Int]]) -> [[Int]] {
	
	let height = input.count
	let width = input[0].count
	
	// parent 배열 초기화
	var parent = Array(0..<height*width)
	
	// find 함수 정의
	func find(_ x: Int) -> Int {
		if parent[x] == x {
			return x
		}
		parent[x] = find(parent[x])
		return parent[x]
	}
	
	// union 함수 정의
	func union(_ x: Int, _ y: Int) {
		let parentX = find(x)
		let parentY = find(y)
		if parentX != parentY {
			parent[parentY] = parentX
		}
	}
	
	// union-find 알고리즘으로 덩어리들을 합쳐줍니다.
	for y in 0..<height {
		for x in 0..<width {
			if input[y][x] == 0 {
				if y > 0 && input[y-1][x] == 0 {
					union(y*width+x, (y-1)*width+x)
				}
				if x > 0 && input[y][x-1] == 0 {
					union(y*width+x, y*width+(x-1))
				}
			}
		}
	}
	
	// 각 덩어리들의 부모 노드를 찾습니다.
	var rootSet = Set<Int>()
	for y in 0..<height {
		for x in 0..<width {
			if input[y][x] == 0 {
				let parentIdx = find(y*width+x)
				rootSet.insert(parentIdx)
			}
		}
	}
	
	// 가장 큰 덩어리 중 하나만 남기고 나머지는 1로 바꿔줍니다.
	var ans = Array(repeating: Array(repeating: 1, count: width), count: height)
	var maxCount = 0
	var maxRoot = 0
	for root in rootSet {
		var count = 0
		for y in 0..<height {
			for x in 0..<width {
				if input[y][x] == 0 && find(y*width+x) == root {
					count += 1
				}
			}
		}
		if count > maxCount {
			maxCount = count
			maxRoot = root
		}
	}
	for y in 0..<height {
		for x in 0..<width {
			if input[y][x] == 0 && find(y*width+x) == maxRoot {
				ans[y][x] = 0
			}
		}
	}
	return ans
	
}
