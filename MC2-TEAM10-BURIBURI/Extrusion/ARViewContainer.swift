//
//  TestARView.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by kimpepe on 2023/05/12.
//

import Foundation
import SwiftUI
import ARKit
import Combine
import RealityKit

class ARViewState: ObservableObject {
    
    @Published var scnNodeArray: [SCNNode] = [] // SCNNode 객체를 저장하는 배열
    @Published var itemPlanArray: [Item] = []
    @Published var starNodesAdded: Bool = false // 별 노드가 추가되었는지를 나타내는 불리언 변수
    // This property retains the cancellable object for our SceneEvents.Update subscriber
    
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var dataModel: DataModel
    @EnvironmentObject var arViewState: ARViewState // AR 뷰 상태를 감시하는 ObservedObject
    
    var arView: ARSCNView?
    
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView() // ARSCNView 인스턴스 생성
        arView.delegate = context.coordinator // 코디네이터를 델리게이트로 설정
        arView.autoenablesDefaultLighting = true
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints] // AR 뷰에서 특징점 표시
        
        let scene = SCNScene() // 새로운 씬 생성
        
        // Create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)

        // Place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)

        arView.scene = scene // AR 뷰에 씬 설정
        arView.allowsCameraControl = false
        
        // AR 세션 설정 추가
        let configuration = ARWorldTrackingConfiguration() // 새로운 AR 월드 트래킹 설정 생성
        configuration.planeDetection = .horizontal // 수평 평면 감지 활성화
         
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors]) // 옵션과 함께 AR 세션 실행
        
            
        
        return arView // AR 뷰 반환
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {
        context.coordinator.arView = uiView
        context.coordinator.context = context
    }

//    private func updateScene(for arView: ARSCNView, context: Context) {
//        if arViewState.scnNodeArray.count < arViewState.itemPlanArray.count {
//            let newStarNodes = context.coordinator.updateStarNodes(with: arViewState.itemPlanArray.last!, in: arView)
//            DispatchQueue.main.async {
//                self.arViewState.scnNodeArray.append(contentsOf: newStarNodes)
//            }
//        }
//    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(arView: self.arView, context: nil) // 새로운 코디네이터 생성
    }
}
