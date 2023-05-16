//
//  getDownRightCrescent.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by Wonil Lee on 2023/05/17.
//

import Foundation

func getPixelDownRightCrescent(r: Int) -> [(Int, Int)] {
	var downRightCrescent: [(Int, Int)] = []

	for i in (-r)...(r) {
		for j in (-r)...(r) {
			if i*i + j*j <= r * r &&  (i+1)*(i+1) + (j+1)*(j+1) > r * r {
				downRightCrescent.append((i, j))
			}
		}
	}
	return downRightCrescent
}
