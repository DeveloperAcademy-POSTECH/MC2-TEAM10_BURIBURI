//
//  PNGImageView.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import SwiftUI

struct PNGImageView: View {
	let pngURL: URL
	
	var body: some View {
		Group {
			if let data = try? Data(contentsOf: pngURL),
			   let image = UIImage(data: data) {
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

//struct PNGImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        PNGImageView()
//    }
//}
