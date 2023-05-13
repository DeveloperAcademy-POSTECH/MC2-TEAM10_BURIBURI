//
//  AlbumForChildView.swift
//  MC2_BuriBuri
//
//  Created by xnoag on 2023/05/09.
//

//* -> 현재 단계
// -> 코드 설명

import SwiftUI
import ARKit

//* 아이를 위한 앨범을 만든다.
struct AlbumForChildView: View {
    // 파일 DataModel을 받아올 준비를한다.
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var arViewState: ARViewState
    
    // 앨범은 3행으로 설정한다.
    private static let Rows = 1
    // 앨범은 NX1 형태이다.
    //    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: Columns)
    @State private var gridRows = Array(repeating: GridItem(.flexible()), count: Rows)
    // isAnimation의 Boolean 값에 따라 이미지가 흔들거리는 효과 여부를 결정한다.
    @State var isAnimationChild = false
    
    var body: some View {
        
        VStack {
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridRows) {
                    ForEach(dataModel.items) { item in
                        
                        GeometryReader { geo in
                            GridItemView(size: geo.size.height, item: item)
                                .rotationEffect((Angle(degrees: isAnimationChild ? 5 : -5)))
                                .onAppear {
                                    print("item here.. url: \(item.url)")
                                    DispatchQueue.main.async {
                                        withAnimation(.easeInOut(duration: 0.3).repeatForever(autoreverses: true)) {
                                            isAnimationChild.toggle()
                                        }
                                    }
                                }
                                .onTapGesture {
                                    DispatchQueue.main.async {
                                        
                                        print("=============")
                                        arViewState.itemPlanArray.append(item)
                                        print("itemPlanArray: \(arViewState.itemPlanArray)")
                                        
                                        Coordinator.summonTrigger = true
                                        Coordinator.scnNodeArray = arViewState.scnNodeArray
                                        Coordinator.itemPlanArray = arViewState.itemPlanArray
                                        
                                        let timer = Timer(timeInterval: 0.02, repeats: true) { timer in
                                            if !Coordinator.summonTrigger {
                                                arViewState.scnNodeArray = Coordinator.scnNodeArray
                                                arViewState.itemPlanArray = Coordinator.itemPlanArray
                                                timer.invalidate()
                                                print("success")
                                                print("arViewState.scnNodeArray.count: \(arViewState.scnNodeArray.count)")
                                                print("arViewState.itemPlanArray.count: \(arViewState.itemPlanArray.count)")
                                            }
                                        }
                                    }
                                }

                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
        }
        .background(Color.clear)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AlbumForChildView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumForChildView()
    }
}
