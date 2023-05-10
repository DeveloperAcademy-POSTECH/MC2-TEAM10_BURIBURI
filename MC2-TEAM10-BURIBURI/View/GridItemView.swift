//
//  GridItemView.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/08.
//

//* -> 현재 단계
// -> 코드 설명

import SwiftUI

struct GridItemView: View {
    let size: Double
    let item: Item

    var body: some View {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: item.url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: size, height: size)
            }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "111", withExtension: "png") {
            GridItemView(size: 50, item: Item(url: url))
        }
    }
}
