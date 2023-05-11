//
//  ReformedBinaryMultiarrayView.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import SwiftUI

struct BinaryMultiarrayView: View {
	let input: [[Int]]
	var scaleDivider: Int
	
	var height: Int {
		input.count
	}
	var width: Int {
		input[0].count
	}
	
	var body: some View {
		HStack(spacing: 0) {
			ForEach(0..<width/scaleDivider) { x in
				VStack(spacing: 0) {
					ForEach(0..<height/scaleDivider) { y in
						switch input[min(scaleDivider * y, height - 1)][min(scaleDivider * x, width - 1)] {
							case 0:
								Color(white: 0.0)
							case 1:
								Color(white: 1.0)
							case 2:
								Color(red: 0.4, green: 0.8, blue: 0.5)
							default:
								Color(.red)
						}
					}
				}
			}
		}
		.frame(width: CGFloat(width / scaleDivider), height: CGFloat(height / scaleDivider))
	}
}

//struct ReformedBinaryMultiarrayView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReformedBinaryMultiarrayView()
//    }
//}
