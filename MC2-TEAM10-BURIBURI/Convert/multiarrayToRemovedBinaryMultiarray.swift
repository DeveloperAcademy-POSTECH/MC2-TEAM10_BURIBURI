//
//  multiarrayToRemovedBinaryMultiarray.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import Foundation
import UIKit

func multiarrayToRemovedBinaryMultiarray(_ multiarray: [[UIColor]]) -> [[Int]] {
	
	// 흑백 사진 멀티어레이
	let monochromeMultiarray = colorToMonochrome(multiarray)
	print("monochrome done!")
	
	// 평균 밝기
	let averageBrightness = monochromeToAverageBrightness(monochromeMultiarray)
	print("averageBrightness done!")
	
	// 기준 밝기
	let middleBrightness = averageBrightnessToMiddleBrightness(averageBrightness)
	print("middleBrightness done!")
	
	// 기준 밝기에 따라 1과 0으로 바꾼 멀티어레이
	let binaryMultiarray = monochromeToBinary(monochromeMultiarray, middleBrightness)
	print("binary done!")
	
	// 선이 부풀어오르게 한 멀티어레이
	// Swell의 기준이 되는 원의 크기는 binaryToSwelledBinary 함수 안에서 정의된다
	let swelledBinaryMultiarray = binaryToSwelledBinary(binaryMultiarray)
	print("swelled done!")
	
	// 하나의 덩어리만 남긴 멀티어레이
	let heroBinaryMultiarray = swelledBinaryToHeroBinary(swelledBinaryMultiarray)
	print("hero done!")
	
//	// 하나의 덩어리를 기준으로 상하좌우 여백을 없앤 멀티어레이
//	let reformedBinaryMultiarray = heroBinaryToReformedBinary(heroBinaryMultiarray)
//	print("reformed done!")
	
	// 배경에 해당하는 픽셀의 원소값을 2로 바꾼 멀티어레이
	let removedBinaryMultiarray = heroBinaryToRemovedBinary(heroBinaryMultiarray)
	print("removed done!")
	
	return removedBinaryMultiarray
}
