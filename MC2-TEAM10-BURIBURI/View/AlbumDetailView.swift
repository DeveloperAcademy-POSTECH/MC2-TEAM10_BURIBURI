//
//  AlbumDetailView.swift
//  MC2_BuriBuri
//
//  Created by xnoag on 2023/05/09.
//

//* -> 현재 단계
// -> 코드 설명

import SwiftUI

//* 부모용 앨범뷰에서 사진을 클릭하면 크게볼 수 있게 한다.
struct AlbumDetailView: View {
    let item: Item
    var body: some View {
        AsyncImage(url: item.url) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        if let url = Bundle.main.url(forResource: "111", withExtension: "png") {
            AlbumDetailView(item: Item(url: url))
        }
    }
}
