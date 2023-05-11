//
//  PNGImageDataView.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/10.
//

import SwiftUI

struct PNGImageDataView: View {
	let pngData: Data
	
	var body: some View {
		Group {
			if let image = UIImage(data: pngData) {
				Image(uiImage: image)
					.resizable()
					.aspectRatio(contentMode: .fit)
			} else {
				Text("Unable to load image")
					.foregroundColor(.red)
			}
		}
	}
}

