//
//  removedBinaryMultiarrayToPlainUSDZ.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/08.
//

import Foundation

func removedBinaryMultiarrayToPlainUSDZ(_ rbm: [[Int]]) -> Data {
	
	let croppedRBM = rbmToCroppedRBM(rbm)
	
	let pointArray = rbmToPointArray(croppedRBM)
	
//	let data = pointArrayToPlainUSDZ(pointArray)
	
	return Data()
	//return data
}
