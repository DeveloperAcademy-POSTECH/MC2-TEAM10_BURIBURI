//
//  PageModel.swift
//  ParOn_Yubin
//
//  Created by Yubin on 2023/05/10.
//

import Foundation

struct Page : Identifiable, Equatable {
    let id = UUID()
//    var name: String
    var description: String
    var imageUrl: String
    var tag: Int
    
    static var samplePage = Page(description: "This is a sample description for the purpose of debugging", imageUrl: "work", tag: 0)
    
    static var samplePages: [Page] = [
        Page(description: "가급적 흰 종이에 어두운 펜을 사용해주세요. \n종이와 펜의 명도 차이가 크지 않으면 인식이 잘 안 될 수 있어요.", imageUrl: "D_Beatle", tag: 0),
        Page(description: "스캔할 때는 화면에 그림이 꽉 차게 찍어주세요.", imageUrl: "D_Plane", tag: 1),
        Page(description: "아이들에게 넓은 공간에서 ar을 사용하도록 이끌어주세요.", imageUrl: "D_RibbonGirl", tag: 2),
    ]
    
}
