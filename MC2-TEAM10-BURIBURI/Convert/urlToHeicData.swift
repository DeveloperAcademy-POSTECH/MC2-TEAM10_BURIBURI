//
//  urlToHeicData.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by Wonil Lee on 2023/05/12.
//

import Foundation

func urlToHeicData(_ url: URL) throws -> Data {
	var imageData = Data()
	do {
		imageData = try Data(contentsOf: url)
	} catch {
		print("Error loading image data: \(error)")
	}
	print(imageData.count)
	return imageData
}
