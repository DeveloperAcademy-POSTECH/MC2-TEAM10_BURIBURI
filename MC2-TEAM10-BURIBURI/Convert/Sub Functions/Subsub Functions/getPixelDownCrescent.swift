//
//  getDownCrescent.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by Wonil Lee on 2023/05/17.
//

import Foundation

func getPixelDownCrescent(r: Int) -> [(Int, Int)] {
	var downCrescent: [(Int, Int)] = []

	for i in (-r)...(r) {
		for j in (-r)...(r) {
			if i*i + j*j <= r * r &&  i*i + (j+1)*(j+1) > r * r {
				downCrescent.append((i, j))
			}
		}
	}
	return downCrescent
}
