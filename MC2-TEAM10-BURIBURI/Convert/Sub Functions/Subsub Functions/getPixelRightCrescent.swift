//
//  getPixelRightCrescent.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by Wonil Lee on 2023/05/17.
//

import Foundation

func getPixelRightCrescent(r: Int) -> [(Int, Int)] {
	
	var rightCrescent: [(Int, Int)] = []

	for i in (-r)...(r) {
		for j in (-r)...(r) {
			if i*i + j*j <= r * r && (i+1)*(i+1) + j*j > r * r {
				rightCrescent.append((i, j))
			}
		}
	}
	
	return rightCrescent
}
