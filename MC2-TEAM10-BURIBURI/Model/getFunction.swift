//
//  getFunction.swift
//  FileManagerTest
//
//  Created by xnoag on 2023/05/08.
//

import Foundation
import SwiftUI

// 메인 UIScreen 화면의 너비, 높이의 값을 받아오는 함수를 정의한다.
// GeometryReader를 사용해서 화면을 구현하는 것 보다 안정적이라고 한다.

// UIScreen의 너비값을 CGFloat 형태로 받아오는 함수
func getWidth() -> CGFloat {
    return UIScreen.main.bounds.width
}

// UIScreen의 높이값을 CGFloat 형태로 받아오는 함수
func getHeight() -> CGFloat {
    return UIScreen.main.bounds.height
}
