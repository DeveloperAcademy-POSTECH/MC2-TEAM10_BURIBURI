//
//  TestARView.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by kimpepe on 2023/05/12.
//

import Foundation
import SwiftUI
import ARKit

class ARViewState: ObservableObject {
    @Published var scnNodeArray: [SCNNode] = [] // SCNNode 객체를 저장하는 배열
    @Published var starNodesAdded: Bool = false // 별 노드가 추가되었는지를 나타내는 불리언 변수
}

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var arViewState: ARViewState // AR 뷰 상태를 감시하는 ObservedObject
    var pointsTuple: [[CGPoint]] // SCNNode 객체를 생성하기 위한 점들의 튜플 배열
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView() // ARSCNView 인스턴스 생성
        arView.delegate = context.coordinator // 코디네이터를 델리게이트로 설정
        arView.autoenablesDefaultLighting = true
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints] // AR 뷰에서 특징점 표시
        
        let scene = SCNScene() // 새로운 씬 생성
        arView.scene = scene // AR 뷰에 씬 설정

        // AR 세션 설정 추가
        let configuration = ARWorldTrackingConfiguration() // 새로운 AR 월드 트래킹 설정 생성
        configuration.planeDetection = .horizontal // 수평 평면 감지 활성화
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors]) // 옵션과 함께 AR 세션 실행
        
        return arView // AR 뷰 반환
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {
        if !arViewState.starNodesAdded {
            let newStarNodes = context.coordinator.updateStarNodes(with: pointsTuple, in: uiView) // AR 뷰에서 별 노드 업데이트

            DispatchQueue.main.async {
                self.arViewState.scnNodeArray = newStarNodes // AR 뷰 상태의 SCNNode 배열 업데이트
                self.arViewState.starNodesAdded = true // 별 노드가 추가되었다는 것을 표시
            }
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator() // 새로운 코디네이터 생성
    }
}
