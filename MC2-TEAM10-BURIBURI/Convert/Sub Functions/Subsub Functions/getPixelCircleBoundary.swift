//
//  getPixelCircleBoundary.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by Wonil Lee on 2023/05/17.
//

import Foundation

func getPixelCircleBoundary(r: Int) -> [(Int, Int)] {
	
	var arr: [(Int, Int)] = []

	for i in (-r)...(r) {
		for j in (-r)...(r) {
			if i*i + j*j <= r * r {
				arr.append((i, j))
			}
		}
	}


	var background = Array(repeating: Array(repeating: 0, count: 2 * r + 1), count: 2 * r + 1)

	for item in arr {
		background[item.0 + r][item.1 + r] = 1
	}


	var backgroundHorizontal = Array(repeating: Array(repeating: 0, count: 2 * r + 1), count: 2 * r + 1)
	var backgroundVertical = Array(repeating: Array(repeating: 0, count: 2 * r + 1), count: 2 * r + 1)



	for i in 0..<(2 * r + 1) {

		var tmp = [Int]()

		for j in 0..<(2 * r + 1) {
			if background[i][j] == 1 {
				tmp.append(j)
			}
		}

		for j in tmp {
			let minV = tmp.min()
			let maxV = tmp.max()
			backgroundHorizontal[i][minV!] = 1
			backgroundHorizontal[i][maxV!] = 1
		}
	}


	for i in 0..<(2 * r + 1) {

		var tmp = [Int]()

		for j in 0..<(2 * r + 1) {
			if background[j][i] == 1 {
				tmp.append(j)
			}
		}

		for j in tmp {
			let minV = tmp.min()
			let maxV = tmp.max()
			backgroundVertical[minV!][i] = 1
			backgroundVertical[maxV!][i] = 1
		}
	}

	for i in 0..<(2 * r + 1) {
		for j in 0..<(2 * r + 1) {
			background[i][j] = (backgroundVertical[i][j] == 1 || backgroundHorizontal[i][j] == 1) ? 1 : 0
		}
	}

	var arr2 = [(Int, Int)]()
	arr2.append((2*r, r))

	struct Point: Hashable {
		let x: Int
		let y: Int
	}

	func bfs(grid: [[Int]], start: Point, end: Point) -> Int {
		let directions: [(Int, Int)] = [
		(-1, -1), (-1, 0), (-1, 1),
		(0, -1), (0, 1),
		(1, -1), (1, 0), (1, 1)
		]

		var queue = [(start, 0)]
		arr2.append((start.x, start.y))
	//	var visited = Set<Point>()

		while !queue.isEmpty {
			let (current, steps) = queue.removeFirst()

			if current == end {
				return steps
			}

			for direction in directions {
				let neighbor = Point(x: current.x + direction.0, y: current.y + direction.1)

				if neighbor.x < 0 || neighbor.x >= grid.count || neighbor.y < 0 || neighbor.y >= grid[0].count {
					continue
				}

				let tuple1 = (neighbor.x, neighbor.y)

				if arr2.contains(where: {$0 == tuple1}) || grid[neighbor.x][neighbor.y] == 0 {
					continue
				}

				arr2.append((neighbor.x, neighbor.y))
				queue.append((neighbor, steps + 1))
			}
		}

		return 0
	}



	let startPoint = Point(x: 2 * r - 1, y: r - 1)
	let endPoint = Point(x: r * 10, y: r * 10)

	bfs(grid: background, start: startPoint, end: endPoint)

	for i in 0..<arr2.count {
		arr2[i].0 -= r
		arr2[i].1 -= r
	}

	arr2.append((r, 0))
	
	return arr2
	
}
