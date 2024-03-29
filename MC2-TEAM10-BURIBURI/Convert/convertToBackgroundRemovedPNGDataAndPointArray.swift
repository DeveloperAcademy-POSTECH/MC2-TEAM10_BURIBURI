//
//  convertToBackgroundRemovedPNGDataAndPointArray.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/10.
//

import Foundation

func convertToBackgroundRemovedPNGDataAndPointArray(_ heicData: Data) async -> (Data, [CGPoint]) {
	
	// 원본 HEIC 데이터를 입력하면 배경이 지워진 PNG 이미지의 데이터와 (다각형을 그리기 위한) pointArray의 튜플을 반환한다.
	
	// 크기 바꾼 HEIC 데이터 얻기
	var resizedHEICData = Data()
	resizedHEICData = resizeHeicData(heicData: heicData, compressionQuality: 1.0)
	// resizedHEICData에서 2차원 배열 multiarray 얻기
	let multiarray = heicToMultiarray(resizedHEICData)
	
	// multiarray에서 지워질 배경이 2로 표시된 멀티어레이 rbm 얻기
	let rbm = multiarrayToRemovedBinaryMultiarray(multiarray)
	
	// 배경이 지워진 PNG 데이터 객체로 얻기
	// 상하좌우 불필요한 배경 띠도 제거한다. 덩어리의 상하좌우 경계가 곧 이미지의 상하좌우 경계선이 된다.
	var backgroundRemovedPNGData = Data()
	do { backgroundRemovedPNGData = try removedBinaryMultiarrayToBackgroundRemovedPNG(multiarray, rbm)
	} catch {
		print(error)
	}
	
	// rbm에서 상하좌우 불필요한 배경 띠를 제거한 rbm인 croppedRBM 얻기
	let croppedRBM = rbmToCroppedRBM(rbm)
	
	// croppedRBM에서 다각형을 그리기 위한 pointArray 얻기
	let pointArray = croppedRBMToPointArray(croppedRBM)
//	print(pointArray)
	return (backgroundRemovedPNGData, pointArray)
}
