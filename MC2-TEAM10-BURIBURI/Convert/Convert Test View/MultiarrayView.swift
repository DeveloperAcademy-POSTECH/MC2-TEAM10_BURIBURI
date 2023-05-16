//
//  MultiarrayView.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/07.
//

import SwiftUI

struct MultiarrayView: View {
	let input: [[UIColor]]
	var scaleDivider: Int
	
	var height: Int {
		input.count
	}
	var width: Int {
		input[0].count
	}

	
	var body: some View {
		ZStack {
			Color.red
				.frame(width: 100, height: 100)
			Text("\(input.count)")
			VStack(spacing: 0) {
				ForEach(0..<height / scaleDivider) { y in
					HStack(spacing: 0) {
						ForEach(0..<width / scaleDivider) { x in
							Color(input[min(scaleDivider * y, height - 1)][min(scaleDivider * x, width - 1)])
								.frame(width: 1, height: 1)
						}
					}
				}
			}
		}
    }
}

//struct MultiarrayView_Previews: PreviewProvider {
//    static var previews: some View {
//        MultiarrayView()
//    }
//}
