//
//  rbmToPointArray.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/08.
//

import Foundation

func rbmToPointArray(_ input: [[Int]]) -> [CGPoint] {
	var width: Int {
		input.count
	}
	var height: Int {
		input[0].count
	}
	
	let safetySquared = 100 // 직전의 점과 거리의 제곱을 비교하는 그런 기준값..
	
	var toBeReturned = [CGPoint]()
	
	let circle15Boundary: [(Int, Int)] = [(15, 0), (14, -1), (14, -2), (14, -3), (14, -4), (14, -5), (13, -6), (13, -7), (12, -8), (12, -9), (11, -10), (10, -11), (9, -12), (8, -12), (7, -13), (6, -13), (5, -14), (4, -14), (3, -14), (2, -14), (1, -14), (0, -15), (-1, -14), (-2, -14), (-3, -14), (-4, -14), (-5, -14), (-6, -13), (-7, -13), (-8, -12), (-9, -12), (-10, -11), (-11, -10), (-12, -9), (-12, -8), (-13, -7), (-13, -6), (-14, -5), (-14, -4), (-14, -3), (-14, -2), (-14, -1), (-15, 0), (-14, 1), (-14, 2), (-14, 3), (-14, 4), (-14, 5), (-13, 6), (-13, 7), (-12, 8), (-12, 9), (-11, 10), (-10, 11), (-9, 12), (-8, 12), (-7, 13), (-6, 13), (-5, 14), (-4, 14), (-3, 14), (-2, 14), (-1, 14), (0, 15), (1, 14), (2, 14), (3, 14), (4, 14), (5, 14), (6, 13), (7, 13), (8, 12), (9, 12), (10, 11), (11, 10), (12, 9), (12, 8), (13, 7), (13, 6), (14, 5), (14, 4), (14, 3), (14, 2), (14, 1), (15, 0)]
	
	
	
	// input에서 경계선 시작점 p0를 고른다.
	
	var startPoint = (0, 0)
	
	for y in 0..<height {
		for x in 0..<width {
			if input[x][y] == 0 {
				startPoint.0 = x
				startPoint.1 = y
				break
			}
		}
	}
	
	toBeReturned.append(CGPoint(x: startPoint.0, y: startPoint.1))
	
	var prevPoint: (Int, Int)
	var nowPoint: (Int, Int) = startPoint
	
	// p0를 중심으로 반지름 15 원을 둘러보며 경계점 [a1, a2, ...]을 찾는다.
	
	var innerPrevPoint: (Int, Int) = circle15Boundary[0]
	var innerNowPoint: (Int, Int) = circle15Boundary[0]
	
	// 경계점 [a1, a2, ...] 중 하나를 고른다. (= p1)
	var intersectionArray = [(Int, Int)]()
	
	for i in 1..<circle15Boundary.count {
		innerPrevPoint.0 = nowPoint.0 + circle15Boundary[i - 1].0
		innerPrevPoint.1 = nowPoint.1 + circle15Boundary[i - 1].1
		innerNowPoint.0 = nowPoint.0 + circle15Boundary[i].0
		innerNowPoint.1 = nowPoint.1 + circle15Boundary[i].1
		
		let innerPrevPointValue = (0 <= innerPrevPoint.0 && innerPrevPoint.0 < width && 0 <= innerPrevPoint.1 && innerPrevPoint.1 < height) ? input[max(0, min(innerPrevPoint.0, width - 1))][max(0, min(innerPrevPoint.1, height - 1))] : 2
		
		let innerNowPointValue = (0 <= innerNowPoint.0 && innerNowPoint.0 < width && 0 <= innerNowPoint.1 && innerNowPoint.1 < height) ? input[max(0, min(innerNowPoint.0, width - 1))][max(0, min(innerNowPoint.1, height - 1))] : 2
		
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
		innerPrevPoint = circle15Boundary[0] // 아무거나 쓴 것
		innerNowPoint = circle15Boundary[0] // 아무거나 쓴 것
		
		// 경계점 [a1, a2, ...] 중 하나를 고른다.
		var intersectionArray = [(Int, Int)]()
		
		// // nowPoint를 중심으로 반지름 15 원을 둘러보며 경계점 [a1, a2, ...]을 찾는다.
		for i in 1..<circle15Boundary.count {
			innerPrevPoint.0 = nowPoint.0 + circle15Boundary[i - 1].0
			innerPrevPoint.1 = nowPoint.1 + circle15Boundary[i - 1].1
			innerNowPoint.0 = nowPoint.0 + circle15Boundary[i].0
			innerNowPoint.1 = nowPoint.1 + circle15Boundary[i].1
			
			let innerPrevPointValue = (0 <= innerPrevPoint.0 && innerPrevPoint.0 < width && 0 <= innerPrevPoint.1 && innerPrevPoint.1 < height) ? input[max(0, min(innerPrevPoint.0, width - 1))][max(0, min(innerPrevPoint.1, height - 1))] : 2
			
			let innerNowPointValue = (0 <= innerNowPoint.0 && innerNowPoint.0 < width && 0 <= innerNowPoint.1 && innerNowPoint.1 < height) ? input[max(0, min(innerNowPoint.0, width - 1))][max(0, min(innerNowPoint.1, height - 1))] : 2
			
			if innerPrevPointValue == 2 && innerNowPointValue != 2 {
				if distanceSquared(from: innerNowPoint, to: prevPoint) > safetySquared {
					intersectionArray.append(innerNowPoint)
					// 가까운 녀석은 넣지 않는다
					
				}
			}
		}
		
		// prevPoint, nowPoint 갱신
		prevPoint = nowPoint
		nowPoint = intersectionArray.count > 0 ? intersectionArray[0] : (0, 0)
		
		// toBeReturned에 더해주기
		toBeReturned.append(CGPoint(x: nowPoint.0, y: nowPoint.1))
		
		
		// nowPoint가 시작점 p0와 일정 거리(15) 미만일 때 끝내기.
		if distanceSquared(from: nowPoint, to: startPoint) < 225 || toBeReturned.count >= 1000 {
			break
		}
	}
	
	return toBeReturned
}


func distanceSquared(from x: (Int, Int), to y: (Int, Int)) -> Int {
	return (x.0 - y.0) * (x.0 - y.0) + (x.1 - y.1) * (x.1 - y.1)
}
