//
//  HEICImageView.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import SwiftUI
import ImageIO

struct HEICImageView: View {
	let heicURL: URL
	
	var body: some View {
		Group {
			if let data = try? Data(contentsOf: heicURL),
			   let imageSource = CGImageSourceCreateWithData(data as CFData, nil),
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

//struct HEICImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        HEICImageView()
//    }
//}
