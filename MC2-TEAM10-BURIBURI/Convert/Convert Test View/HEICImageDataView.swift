//
//  HEICImageDataView.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/10.
//

import SwiftUI

struct HEICImageDataView: View {
	let heicData: Data
	
	var body: some View {
		Group {
			if let imageSource = CGImageSourceCreateWithData(heicData as CFData, nil),
			   let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil) {
				Image(uiImage: UIImage(cgImage: image))
					.resizable()
					.aspectRatio(contentMode: .fit)
			} else {
				Text("Unable to load image")
					.foregroundColor(.red)
			}
		}
	}
}


