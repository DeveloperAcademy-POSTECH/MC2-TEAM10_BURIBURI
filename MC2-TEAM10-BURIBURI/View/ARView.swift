//
//  ARView.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/08.
//

import SwiftUI

struct ARView: View {
    @State private var isUnBoxing = false
    @State private var isCameraOpen = false
    var body: some View {
        ZStack {
            Image("OnboardingBG")
                .scaledToFill()
            VStack {
                Spacer()
                    .frame(width: getWidth() * 0.1, height: getHeight() * 0.05)
                HStack {
                    Spacer()
                        .frame(width: getWidth() * 0.03, height: getHeight() * 0.05)
//                    Button(action: {
//                        isCameraOpen.toggle()
//                    }) {
//                        Image("C_Wand_01")
//                            .resizable()
//                            .aspectRatio(1, contentMode: .fit)
//                            .foregroundColor(.green)
//                            .frame(width: getWidth() * 0.1, height: getHeight() * 0.05)
//                    }
                    NavigationLink(destination: CameraView()) {
                        Image("C_Wand_01")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundColor(.green)
                            .frame(width: getWidth() * 0.1, height: getHeight() * 0.05)
                    }
                    Spacer()
                        .frame(width: getWidth() * 0.87, height: getHeight() * 0.05)
                }
                Spacer()
                    .frame(width: getWidth() * 1, height: getHeight() * 0.7)
                Button(action: {
                    let generator = UINotificationFeedbackGenerator()
                                    generator.notificationOccurred(.success)
                    isUnBoxing.toggle()
                }) {
                    if isUnBoxing {
                        Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundColor(.clear)
                            .frame(width: getWidth() * 1, height: getHeight() * 0.1)
                    } else {
                        Image("C_Fedora3_02")
                            .resizable()
//                        Rectangle()
                            .aspectRatio(1, contentMode: .fit)
                            .foregroundColor(.blue)
                            .frame(width: getWidth() * 1, height: getHeight() * 0.1)
                    }
                }
                Spacer()
                    .frame(width: getWidth() * 1, height: getHeight() * 0.1)
            }
            .sheet(isPresented: $isUnBoxing) {
                NavigationView {
                    AlbumForChildView()
                }
                .clearModalBackground()
                .presentationDetents([.height(getHeight() * 0.33)])
            }
//            .sheet(isPresented: $isCameraOpen) {
//                NavigationView {
//                    CameraView()
//                }
//            }
        }
        .navigationBarHidden(true)
    }
}



struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
}
