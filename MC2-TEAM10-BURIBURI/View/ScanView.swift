//
//  ScanView.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/08.
//

import SwiftUI
//현재(2023. 5. 14. 오전 5:42) CameraView가 스캔 뷰 역할을 하는 중
struct ScanView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(width: getWidth() * 1, height: getHeight() * 0.1)
            Spacer()
                .frame(width: getWidth() * 1, height: getHeight() * 0.7)
            HStack {
                Spacer()
                    .frame(width: getWidth() * 0.03, height: getHeight() * 0.1)
                NavigationLink(destination: AlbumForParentsView()) {
                    Image("C_Fedora3_02")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(.blue)
                        .frame(width: getWidth() * 0.2, height: getHeight() * 0.1)
                }
                Spacer()
                    .frame(width: getWidth() * 0.17, height: getHeight() * 0.1)
                Rectangle()
                    .foregroundColor(.blue)
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: getWidth() * 0.2, height: getHeight() * 0.1)
                Spacer()
                    .frame(width: getWidth() * 0.4, height: getHeight() * 0.1)
            }
            Spacer()
                .frame(width: getWidth() * 1, height: getHeight() * 0.1)
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
