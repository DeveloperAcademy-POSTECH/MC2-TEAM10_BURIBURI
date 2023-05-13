//
//  pathToExtrude.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by kimpepe on 2023/05/12.
//

import Foundation
import ARKit // ARKit 라이브러리를 가져옴

class Coordinator: NSObject, ARSCNViewDelegate { // NSObject와 ARSCNViewDelegate를 상속하는 Coordinator 클래스 선언
    
    private func createStarPath(from points: [CGPoint]) -> UIBezierPath { // 점들의 배열로부터 별 모양의 경로를 만드는 메소드
        let path = UIBezierPath() // UIBezierPath 객체를 생성
        
        path.move(to: points[0]) // 경로를 첫 번째 점으로 이동
        
        for i in 1..<points.count { // 배열의 나머지 점들에 대해
            path.addLine(to: points[i]) // 현재 점에서 다음 점까지 선을 추가
        }
        path.close() // 경로를 닫음 (처음과 마지막 점을 연결)
        return path // 경로를 반환
    }
    
    func createStarNode(with points: [CGPoint], imageName: String) -> SCNNode { // 주어진 점들과 이미지 이름으로 별 노드를 생성하는 메소드
        let sides = points.count // 별의 변의 수를 계산
        let textureImage = UIImage(named: imageName) // 텍스처 이미지를 로드
        let sideImage = UIImage(named: "SideFrame") // 변의 이미지를 로드
        
        let starPath = createStarPath(from: points) // 별 경로를 생성
        let shape = SCNShape(path: starPath, extrusionDepth: 0.1) // 별 경로와 돌출 깊이로 3D 형태를 생성
        
        let rotationAngle = CGFloat.pi / CGFloat(sides) // 회전 각도를 계산
        
        let sideMaterial = SCNMaterial() // 변의 재질을 생성
        sideMaterial.diffuse.contents = sideImage // 변의 텍스처를 설정
        sideMaterial.diffuse.wrapS = .repeat // S 방향의 텍스처를 반복
        sideMaterial.diffuse.wrapT = .repeat // T 방향의 텍스처를 반복
        sideMaterial.diffuse.contentsTransform = SCNMatrix4MakeRotation(Float(rotationAngle), 0, 0, 1) // 변의 텍스처를 회전
        
        let frontMaterial = SCNMaterial() // 앞면의 재질을 생성
        frontMaterial.diffuse.contents = textureImage // 앞면의 텍스처를 설정
        
        let backMaterial = SCNMaterial() // 뒷면의 재질을 생성
        backMaterial.diffuse.contents = textureImage // 뒷면의 텍스처를 설정
        backMaterial.diffuse.wrapS = .repeat // S 방향의 텍스처를 반복
        backMaterial.diffuse.wrapT = .repeat // T 방향의 텍스처
        backMaterial.diffuse.contentsTransform = SCNMatrix4MakeRotation(Float(rotationAngle), 0, 0, 1) // 뒷면의 텍스처를 회전

        shape.materials = [frontMaterial, backMaterial] + Array(repeating: sideMaterial, count: sides) // 각면에 재질을 적용
        
        let starNode = SCNNode(geometry: shape) // 생성한 형태로 SCNNode를 생성
        starNode.position = SCNVector3(0, 0, -1) // 노드의 위치를 설정
        starNode.scale = SCNVector3(0.5, 0.5, 0.5) // 노드의 크기를 설정
        
        return starNode // 생성한 노드를 반환
    }
    
    func updateStarNodes(with pointsTuple: [[CGPoint]], in arView: ARSCNView) -> [SCNNode] { // 주어진 점들의 배열로 별 노드들을 업데이트 하는 메소드
        var starNodes: [SCNNode] = [] // 별 노드들을 저장할 빈 배열을 생성
        
        for points in pointsTuple { // 각 점들의 배열에 대해
            let starNode = createStarNode(with: points, imageName: "Godliver") // 별 노드를 생성
            arView.scene.rootNode.addChildNode(starNode) // AR 뷰의 루트 노드에 별 노드를 추가
            starNodes.append(starNode) // 별 노드를 배열에 추가
        }
        
        return starNodes // 별 노드들의 배열을 반환
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 필요한 경우 구현: AR 앵커가 추가되었을 때 호출되는 메소드
    }
}
