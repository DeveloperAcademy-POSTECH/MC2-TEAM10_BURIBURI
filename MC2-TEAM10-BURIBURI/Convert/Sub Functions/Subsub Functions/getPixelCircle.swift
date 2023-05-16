//
//  getPixelCircle.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by Wonil Lee on 2023/05/17.
//

import Foundation

func getPixelCircle(r: Int) -> [(Int, Int)] {
	
	var toBeReturned: [(Int, Int)] = []

	for i in (-r)...(r) {
		for j in (-r)...(r) {
			if i*i + j*j <= r * r {
				toBeReturned.append((i, j))
			}
		}
	}
	return toBeReturned
}
