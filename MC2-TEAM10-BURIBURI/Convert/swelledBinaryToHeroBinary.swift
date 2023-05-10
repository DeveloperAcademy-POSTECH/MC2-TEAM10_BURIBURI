//
//  swelledBinaryToHeroBinary.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/10.
//

import Foundation

func swelledBinaryToHeroBinary(_ input: [[Int]]) -> [[Int]] {
	
	let width = input.count
	let height = input[0].count
	
	// parent 배열 초기화
	var parent = Array(0..<width*height)
	
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
	for i in 0..<width {
		for j in 0..<height {
			if input[i][j] == 0 {
				if i > 0 && input[i-1][j] == 0 {
					union(i*height+j, (i-1)*height+j)
				}
				if j > 0 && input[i][j-1] == 0 {
					union(i*height+j, i*height+(j-1))
				}
			}
		}
	}
	
	// 각 덩어리들의 부모 노드를 찾습니다.
	var rootSet = Set<Int>()
	for i in 0..<width {
		for j in 0..<height {
			if input[i][j] == 0 {
				let parentIdx = find(i*height+j)
				rootSet.insert(parentIdx)
			}
		}
	}
	
	// 가장 큰 덩어리 중 하나만 남기고 나머지는 1로 바꿔줍니다.
	var ans = Array(repeating: Array(repeating: 1, count: height), count: width)
	var maxCount = 0
	var maxRoot = 0
	for root in rootSet {
		var count = 0
		for i in 0..<width {
			for j in 0..<height {
				if input[i][j] == 0 && find(i*height+j) == root {
					count += 1
				}
			}
		}
		if count > maxCount {
			maxCount = count
			maxRoot = root
		}
	}
	for i in 0..<width {
		for j in 0..<height {
			if input[i][j] == 0 && find(i*height+j) == maxRoot {
				ans[i][j] = 0
			}
		}
	}
	return ans
	
}
