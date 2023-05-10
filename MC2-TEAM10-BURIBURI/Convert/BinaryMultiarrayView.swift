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
	
	var width: Int {
		input.count
	}
	var height: Int {
		input[0].count
	}
	
	var body: some View {
		VStack(spacing: 0) {
			ForEach(0..<height/scaleDivider) { y in
				HStack(spacing: 0) {
					ForEach(0..<width/scaleDivider) { x in
						switch input[min(scaleDivider * x, width - 1)][min(scaleDivider * y, height - 1)] {
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
