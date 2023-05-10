//
//  AlbumForChildView.swift
//  MC2_BuriBuri
//
//  Created by xnoag on 2023/05/09.
//

//* -> 현재 단계
// -> 코드 설명

import SwiftUI

//* 아이를 위한 앨범을 만든다.
struct AlbumForChildView: View {
    // 파일 DataModel을 받아올 준비를한다.
    @EnvironmentObject var dataModel: DataModel
    // 앨범은 3행으로 설정한다.
    private static let Rows = 1
    // 앨범은 NX1 형태이다.
//    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: Columns)
    @State private var gridRows = Array(repeating: GridItem(.flexible()), count: Rows)
    // isAnimation의 Boolean 값에 따라 이미지가 흔들거리는 효과 여부를 결정한다.
    @State var isAnimationChild = false

    
    var body: some View {
        VStack {
            // rkfhfh스크롤 가능하게 한다.
            ScrollView(.horizontal) {
                // 수평(H)방향으로 Grid를 사용한다.
                LazyHGrid(rows: gridRows) {
                    ForEach(dataModel.items) { item in
                        GeometryReader { geo in
                            // GridItemView를 불러와서 item에 item을 넘겨준다.
                            GridItemView(size: geo.size.height, item: item)
                            
                            // 좌우 5도씩 흔들거리는 효과
                                .rotationEffect((Angle(degrees: isAnimationChild ? 5 : -5)))
                            // 0.3초마다 왔다갔다하게 하는 효과
                                .animation(.easeInOut(duration: 0.3)
                                    .repeatForever(autoreverses: true), value: isAnimationChild)
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
            .onAppear {
                isAnimationChild.toggle()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AlbumForChildView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumForChildView()
    }
}
