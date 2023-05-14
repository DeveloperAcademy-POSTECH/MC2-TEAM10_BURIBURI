//
//  ForBackUpApp.swift
//  ForBackUp
//
//  Created by xnoag on 2023/05/10.
//

import SwiftUI

// 키워드는 앱의 진입점을 나타내는 @main.
@main
struct MC2_TEAM10_BURIBURIApp: App {

    init() {
        UINavigationBar.applyCustomAppearance()
    }

    // 데이터 모델을 저장하는 @StateObject 프로퍼티 래퍼를 생성한다.
    @StateObject var dataModel = DataModel()
    // body는 앱에서 실제로 인터페이스가 보여지는 부분이다.
    var body: some Scene {
        WindowGroup {
            // 앱을 켰을 때 어떤 View를 보여준다.
                StartView().environmentObject(dataModel)
            // 가장 먼저 보이는 View에 environmentObject 함수를 사용하여 dataModel 객체를 전달한다.
            // 다른 View에서 dataModel을 사용할 수 있다.
        }
    }
}



fileprivate extension UINavigationBar {
    
    static func applyCustomAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
