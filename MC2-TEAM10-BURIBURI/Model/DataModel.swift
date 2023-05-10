//
//  DataModel.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/08.
//

//* -> 현재 단계
// -> 코드 설명

import Foundation
import SwiftUI

//* 특정 프로퍼티 값이 변경되면 변경 사항을 View에 알리기 위해, ObservableObject 프로토콜을 준수하는 DataModel 클래스를 생성한다.
class DataModel: ObservableObject {
    // items는 데이터가 추가/삭제되면서 변경 가능한 배열이므로 @Published를 붙힌다.
    @Published var items: [Item] = []
    
    init() {
        // FileManager를 사용해서, documentDirectory의 URL을 가져온다.
        if let documentDirectory = FileManager.default.documentDirectory {
            //getContentsOfDirectory를 사용해서, documentDirectory에서 이미지 파일의 URL을 가져온다. isImage 속성을 사용해서 URL이 이미지 파일인지 여부를 확인한다.
            let urls = FileManager.default.getContentsOfDirectory(documentDirectory).filter { $0.isImage }
            // 가져온 URL을 사용해서, item이라는 객체를 만들고, 이 객체(item)을 items 배열에 추가한다.
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
        
        // Bundle.main.urls를 사용해서 main Bundle에서 확장자가 "png"인 모든 리소스의 URL을 가져온다.
        if let urls = Bundle.main.urls(forResourcesWithExtension: "png", subdirectory: nil) {
            for url in urls {
                let item = Item(url: url)
                items.append(item)
            }
        }
    }
    
    // item을 items에 추가하는 함수를 만든다.
    func addItem(_ item: Item) {
        items.insert(item, at: 0)
    }
    
    // item을 items에서 삭제하는 함수를 만든다.
    func removeItem(_ item: Item) {
           if let index = items.firstIndex(of: item) {
               items.remove(at: index)
               FileManager.default.removeItemFromDocumentDirectory(url: item.url)
           }
       }
}



extension URL {
    // URL의 확장자가 이미지 형식들에 맞는지 확인하는 계산 프로퍼티를 생성한다.
    var isImage: Bool {
        let imageExtensions = ["jpg", "jpeg", "png", "gif", "heic"]
        return imageExtensions.contains(self.pathExtension)
    }
}
