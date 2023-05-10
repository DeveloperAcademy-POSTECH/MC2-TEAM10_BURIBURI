//
//  AlbumForParentsView.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/09.
//

//* -> 현재 단계
// -> 코드 설명

import SwiftUI

//* 부모를 위한 앨범을 만든다.
struct AlbumForParentsView: View {
    // 파일 DataModel을 받아올 준비를한다.
    @EnvironmentObject var dataModel: DataModel
    // 앨범은 3열로 설정한다.
    private static let Columns = 3
    // isEditing의 Boolean 값에 따라 편집 여부를 결정한다.
    @State private var isEditing = false
    // 앨범은 3XN 형태이다.
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: Columns)
    // isAnimation의 Boolean 값에 따라 이미지가 흔들거리는 효과 여부를 결정한다.
    @State var isAnimationParents = false
    
    var body: some View {
        VStack {
            // 스크롤 가능하게 한다.
            ScrollView {
                // 수직(V)방향으로 Grid를 사용한다.
                LazyVGrid(columns: gridColumns) {
                    // items 배열안에 요소에 반복적인 작업을 할 건데,
                    ForEach(dataModel.items) { item in
                        GeometryReader { geo in
                            // GridItemView의 각 item에 NavigationLink 부여한다.
                            NavigationLink(destination: AlbumDetailView(item: item)) {
                                // GridItemView를 불러와서 item에 item을 넘겨준다.
                                GridItemView(size: geo.size.width, item: item)
                                    // 좌우 5도씩 흔들거리는 효과
                                    .rotationEffect((Angle(degrees: isAnimationParents ? 5 : -5)))
                                    // 0.3초마다 왔다갔다하게 하는 효과
                                    .animation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true), value: isAnimationParents)
                            }
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                        // isEditing이 ture일 때 이미지 삭제할 수 있는 버튼을 생성한다.
                        .overlay(alignment: .topTrailing) {
                            if isEditing {
                                Button {
                                    withAnimation {
                                        dataModel.removeItem(item)
                                    }
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                        .font(Font.title)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(.white, .red)
                                }
                                .offset(x: 7, y: -7)
                            }
                        }
                    }
                }
                .padding()
            }
            // AlbumForParentsView가 켜질 때 isAnimation을 true로 만들어서 효과 실행되게 한다.
            .onAppear {
                isAnimationParents.toggle()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation { isEditing.toggle() }
                }
            }
        }
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumForParentsView().environmentObject(DataModel())
    }
}
