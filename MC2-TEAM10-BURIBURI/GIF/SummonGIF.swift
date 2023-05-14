//
//  SummonGIF.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by kimpepe on 2023/05/14.
//

// GIF 소환술의 방.

import Foundation
import SwiftUI
import WebKit

// SummonGIF 구조체 선언, UIViewRepresentable 프로토콜을 채택
struct SummonGIF: UIViewRepresentable {
    
    // gif 파일의 이름을 저장하는 프로퍼티
    private let name: String
    
    // 구조체의 초기화 메서드
    init(_ name: String) {
        self.name = name
    }
    
    // makeUIView 메서드 구현, WKWebView 객체 생성하여 gif 파일 로드
    func makeUIView(context: Context) -> WKWebView {
        
        // WKWebView 객체 생성
        let WebView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        
        // gif 파일 데이터 로드
        let data = try! Data(contentsOf: url)
        
        // WKWebView에 gif 파일 로드
        WebView.load(data, mimeType: "image/gif", characterEncodingName: "UTF-8", baseURL: url.deletingLastPathComponent())
        
        // WKWebView 객체 반환
        return WebView
    }
    
    // updateUIView 메서드 구현, 업데이트 시 웹 뷰 리로드
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
        // 웹 뷰 리로드
        uiView.reload()
        
    }
    
    // UIViewType에 WKWebView 타입 설정
    typealias UIViewType = WKWebView
    
}

// SummonGIF_Previews 구조체 선언, 미리보기 기능을 위한 코드
struct SummonGIF_Previews: PreviewProvider {
    static var previews: some View {
        
        // SummonGIF 구조체 호출
        SummonGIF("Parents_Doodle_05")
        SummonGIF("Parents_Scanning_03")
        SummonGIF("Parents_Scanning_04_ns")
        SummonGIF("Title_01")
        
    }
}
