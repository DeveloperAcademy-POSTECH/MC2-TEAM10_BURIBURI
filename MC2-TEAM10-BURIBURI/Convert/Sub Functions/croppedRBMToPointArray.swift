//
//  croppedRBMToPointArray.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/08.
//

import Foundation

func croppedRBMToPointArray(_ input: [[Int]]) -> [CGPoint] {
	let height = input.count
	let width = input[0].count
	
	let safetySquared = 100 // 직전의 점과 거리의 제곱을 비교하는 그런 기준값..
	
	var toBeReturned = [CGPoint]()
	
	let pixelCircleBoundary: [(Int, Int)] = getPixelCircleBoundary(r: 15) // r: 15 권장
	print(pixelCircleBoundary)
	
//	let circle15Boundary: [(Int, Int)] = [(15, 0), (14, -1), (14, -2), (14, -3), (14, -4), (14, -5), (13, -6), (13, -7), (12, -8), (12, -9), (11, -10), (10, -11), (9, -12), (8, -12), (7, -13), (6, -13), (5, -14), (4, -14), (3, -14), (2, -14), (1, -14), (0, -15), (-1, -14), (-2, -14), (-3, -14), (-4, -14), (-5, -14), (-6, -13), (-7, -13), (-8, -12), (-9, -12), (-10, -11), (-11, -10), (-12, -9), (-12, -8), (-13, -7), (-13, -6), (-14, -5), (-14, -4), (-14, -3), (-14, -2), (-14, -1), (-15, 0), (-14, 1), (-14, 2), (-14, 3), (-14, 4), (-14, 5), (-13, 6), (-13, 7), (-12, 8), (-12, 9), (-11, 10), (-10, 11), (-9, 12), (-8, 12), (-7, 13), (-6, 13), (-5, 14), (-4, 14), (-3, 14), (-2, 14), (-1, 14), (0, 15), (1, 14), (2, 14), (3, 14), (4, 14), (5, 14), (6, 13), (7, 13), (8, 12), (9, 12), (10, 11), (11, 10), (12, 9), (12, 8), (13, 7), (13, 6), (14, 5), (14, 4), (14, 3), (14, 2), (14, 1), (15, 0)]
	
	
	
	// input에서 경계선 시작점 p0를 고른다.
	
	var startPoint = (0, 0)
	
	for x in 0..<width {
		var breakChecker = false
		for y in 0..<height {
			if input[y][x] == 0 {
				startPoint.1 = y
				startPoint.0 = x
				breakChecker = true
				break
			}
		}
		if breakChecker {
			break
		}
	}
	
	toBeReturned.append(CGPoint(x: startPoint.0, y: startPoint.1))
	
	var prevPoint: (Int, Int)
	var nowPoint: (Int, Int) = startPoint
	
	// p0를 중심으로 반지름 15 원을 둘러보며 경계점 [a1, a2, ...]을 찾는다.
	
	var innerPrevPoint: (Int, Int) = pixelCircleBoundary[0]
	var innerNowPoint: (Int, Int) = pixelCircleBoundary[0]
	
	// 경계점 [a1, a2, ...] 중 하나를 고른다. (= p1)
	var intersectionArray = [(Int, Int)]()
	
	for i in 1..<pixelCircleBoundary.count {
		innerPrevPoint.0 = nowPoint.0 + pixelCircleBoundary[i - 1].0
		innerPrevPoint.1 = nowPoint.1 + pixelCircleBoundary[i - 1].1
		innerNowPoint.0 = nowPoint.0 + pixelCircleBoundary[i].0
		innerNowPoint.1 = nowPoint.1 + pixelCircleBoundary[i].1
		
		let innerPrevPointValue = (0 <= innerPrevPoint.1 && innerPrevPoint.1 < height && 0 <= innerPrevPoint.0 && innerPrevPoint.0 < width) ? input[max(0, min(innerPrevPoint.1, height - 1))][max(0, min(innerPrevPoint.0, width - 1))] : 2
		
		let innerNowPointValue = (0 <= innerNowPoint.1 && innerNowPoint.1 < height && 0 <= innerNowPoint.0 && innerNowPoint.0 < width) ? input[max(0, min(innerNowPoint.1, height - 1))][max(0, min(innerNowPoint.0, width - 1))] : 2
		
		if innerPrevPointValue == 2 && innerNowPointValue != 2 {
			intersectionArray.append(innerNowPoint)
			
		}
	}
	
	
	// prevPoint = nowPoint (=p0)
	// nowPoint = p1
	prevPoint = nowPoint
	nowPoint = intersectionArray.count > 0 ? intersectionArray[0] : (0, 0)
	
	toBeReturned.append(CGPoint(x: nowPoint.0, y: nowPoint.1))
	
	//toBeReturned 하나씩 채워보기
	while true {
		innerPrevPoint = pixelCircleBoundary[0] // 아무거나 쓴 것
		innerNowPoint = pixelCircleBoundary[0] // 아무거나 쓴 것
		
		// 경계점 [a1, a2, ...] 중 하나를 고른다.
		var intersectionArray = [(Int, Int)]()
		
		// // nowPoint를 중심으로 반지름 15 원을 둘러보며 경계점 [a1, a2, ...]을 찾는다.
		for i in 1..<pixelCircleBoundary.count {
			innerPrevPoint.0 = nowPoint.0 + pixelCircleBoundary[i - 1].0
			innerPrevPoint.1 = nowPoint.1 + pixelCircleBoundary[i - 1].1
			innerNowPoint.0 = nowPoint.0 + pixelCircleBoundary[i].0
			innerNowPoint.1 = nowPoint.1 + pixelCircleBoundary[i].1
			
			let innerPrevPointValue = (0 <= innerPrevPoint.1 && innerPrevPoint.1 < height && 0 <= innerPrevPoint.0 && innerPrevPoint.0 < width) ? input[max(0, min(innerPrevPoint.1, height - 1))][max(0, min(innerPrevPoint.0, width - 1))] : 2
			
			let innerNowPointValue = (0 <= innerNowPoint.1 && innerNowPoint.1 < height && 0 <= innerNowPoint.0 && innerNowPoint.0 < width) ? input[max(0, min(innerNowPoint.1, height - 1))][max(0, min(innerNowPoint.0, width - 1))] : 2
			
			if innerPrevPointValue == 2 && innerNowPointValue != 2 {
				if distanceSquared(from: innerNowPoint, to: prevPoint) > safetySquared {
					intersectionArray.append(innerNowPoint)
					// 가까운 녀석은 넣지 않는다
					
				}
			}
		}
		
		// prevPoint, nowPoint 갱신
		prevPoint = nowPoint
		nowPoint = intersectionArray.count > 0 ? intersectionArray[Int.random(in: 0..<intersectionArray.count)] : (0, 0)
		
		// toBeReturned에 더해주기
		toBeReturned.append(CGPoint(x: nowPoint.0, y: nowPoint.1))
		
		
		// nowPoint가 시작점 p0와 일정 거리(15) 미만일 때 끝내기.
		if distanceSquared(from: nowPoint, to: startPoint) < 225 || toBeReturned.count >= 1000 {
			break
		}
	}
	
	for i in 0..<toBeReturned.count {
        toBeReturned[i].x -= CGFloat(width) / 2
		toBeReturned[i].x /= CGFloat((width + height) / 2)
		
		toBeReturned[i].y = CGFloat(height) - toBeReturned[i].y
		toBeReturned[i].y /= CGFloat((width + height) / 2)
	}
	
	return toBeReturned
}


func distanceSquared(from x: (Int, Int), to y: (Int, Int)) -> Int {
	return (x.0 - y.0) * (x.0 - y.0) + (x.1 - y.1) * (x.1 - y.1)
}
