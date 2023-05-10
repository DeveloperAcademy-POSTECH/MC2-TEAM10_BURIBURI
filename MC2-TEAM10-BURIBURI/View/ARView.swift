//
//  ARView.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/08.
//

import SwiftUI

struct ARView: View {
    @State private var isUnBoxing = false
    var body: some View {
        ZStack {
            Image("ㅋㅋㅋ").scaledToFill()
            VStack {
                Spacer()
                    .frame(width: getWidth() * 0.1, height: getHeight() * 0.05)
                HStack {
                    Spacer()
                        .frame(width: getWidth() * 0.03, height: getHeight() * 0.05)
                    NavigationLink(destination: ScanView()) {
                        Rectangle()
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
                    isUnBoxing.toggle()
                }) {
                    Rectangle()
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(.blue)
                        .frame(width: getWidth() * 1, height: getHeight() * 0.1)
                }
                Spacer()
                    .frame(width: getWidth() * 1, height: getHeight() * 0.1)
            }
            .popover(isPresented: $isUnBoxing) {
                NavigationView {
                    AlbumForChildView(isAnimationChild: true)
                }
                
                .presentationDetents([.height(getHeight() * 0.33)])
            }
        }
    }
}


struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
}
