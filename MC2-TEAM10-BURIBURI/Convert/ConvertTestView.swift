//
//  ContentView.swift
//  SwiftUI Demo 2
//
//  Created by Wonil Lee on 2023/05/05.
//

import SwiftUI
import UIKit

struct ConvertTestView: View {
	
	@State var buttonPressed: Bool = false
	
	@State var rbm = [[Int]]()
	
	@State var resizedHEICData = Data()
	
	@State var brPNGData = Data()
	
	//시뮬레이터를 실행할 맥에서의 이미지 파일 위치에 맞게 URL을 수정해야 사용 가능
	
	let originalURL = URL(fileURLWithPath: "/Users/wonil/Desktop/SwiftProjects/ADA2 Projects/MC2/Shared Project/MC2-Team10-BuriBuri/MC2_BuriBuri/SampleImage/ConvertSampleImage1.HEIC")
	
	var body: some View {
		ScrollView {
			VStack {
				HStack {
					Text("original HEIC file: ")
					HEICImageView(heicURL: originalURL)
						.frame(width: 200)
				}
				
				Button {
					if !buttonPressed {
						
						do {resizedHEICData = try resizeHeicImage(at: originalURL, with: CGSize(width: 750, height: 1000), compressionQuality: 1.0)
						} catch {
							print(error)
						}
						
						let multiarray = heicToMultiArray(resizedHEICData)
						
						rbm = multiarrayToRemovedBinaryMultiarray(multiarray)
						
						do {brPNGData = try removedBinaryMultiarrayToBackgroundRemovedPNG(multiarray, rbm)
						} catch {
							print(error)
						}
					}
					
					buttonPressed.toggle()
				} label: {
					if !buttonPressed {
						Text("Remove Background")
							.foregroundColor(.blue)
					} else {
						Text("reset")
					}
				}
				
//				if buttonPressed {
//					VStack {
//						ForEach(0..<pointArray.count, id: \.self) { i in
//							Text("\(pointArray[i].x) \(pointArray[i].y)")
//						}
//					}
//				}
				
				if buttonPressed {
					
					VStack {
						Image(uiImage: UIImage(data: brPNGData) ?? UIImage())
							.resizable()
							.scaledToFit()
							.frame(width: UIScreen.main.bounds.width * 0.9)
					}
				}
			}
		}
		
		
		
	}
}

struct ConvertTestView_Previews: PreviewProvider {
	static var previews: some View {
		ConvertTestView()
	}
}
