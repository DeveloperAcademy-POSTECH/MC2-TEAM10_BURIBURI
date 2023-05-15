//
//  pathToExtrude.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by kimpepe on 2023/05/12.
//

import Foundation
import ARKit // ARKit 라이브러리를 가져옴
import UIKit



class Coordinator: NSObject, ARSCNViewDelegate { // NSObject와 ARSCNViewDelegate를 상속하는 Coordinator 클래스 선언
    
    static var summonTrigger: Bool = false
    static var scnNodeArray: [SCNNode] = []
    static var itemPlanArray: [Item] = []
    
    var arView: ARSCNView?
    var context: ARViewContainer.Context?
    
    // Add a DispatchQueue specifically for accessing and modifying the scnNodeArray
    static let scnNodeQueue = DispatchQueue(label: "scnNodeQueue", attributes: .concurrent)
    
    init(arView: ARSCNView?, context: ARViewContainer.Context?) {
        self.arView = arView
        self.context = context
    }
    
    private func createStarPath(from points: [CGPoint]) -> UIBezierPath { // 점들의 배열로부터 별 모양의 경로를 만드는 메소드
        let path = UIBezierPath() // UIBezierPath 객체를 생성
        
        path.move(to: points[0]) // 경로를 첫 번째 점으로 이동
        
        for i in 1..<points.count { // 배열의 나머지 점들에 대해
            path.addLine(to: points[i]) // 현재 점에서 다음 점까지 선을 추가
        }
        path.close() // 경로를 닫음 (처음과 마지막 점을 연결)
        return path // 경로를 반환
    }
    
    func createStarNode(with points: [CGPoint], imageURL: URL) -> SCNNode { // 주어진 점들과 이미지 이름으로 별 노드를 생성하는 메소드
        
        let sides = points.count // 별의 변의 수를 계산
        let sideImage = UIImage(named: "SideFrame") // 변의 이미지를 로드
        guard let data = try? Data(contentsOf: imageURL),
              let textureImage = UIImage(data: data) else {
            return SCNNode()
        }
        
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
        //        starNode.position = SCNVector3(0, 0, -1) // 노드의 위치를 설정
        //        starNode.scale = SCNVector3(0.5, 0.5, 0.5) // 노드의 크기를 설정
        
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragObject(_:)))
//        arView?.addGestureRecognizer(panGesture)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(deleteObject(_:)))
        longPressGesture.minimumPressDuration = 0.5
        arView?.addGestureRecognizer(longPressGesture)
        
        
        registerGestureRecognizers()
        
        
        return starNode // 생성한 노드를 반환
    }
    
//    @objc func dragObject(_ gestureRecognizer: UIPanGestureRecognizer) {
//        let touchLocation = gestureRecognizer.location(in: arView)
//        guard let hitTestResult = arView?.hitTest(touchLocation).first else { return }
//
//        var node = hitTestResult.node
//        let translation = gestureRecognizer.translation(in: arView)
//        let x = Float(translation.x)
//        let y = Float(-translation.y)
//        let currentPosition = node.position
//        let hitTestWorldCoord = hitTestResult.worldCoordinates
//        let distance = sqrt(pow(hitTestWorldCoord.x - currentPosition.x, 2) + pow(hitTestWorldCoord.y - currentPosition.y, 2) + pow(hitTestWorldCoord.z - currentPosition.z, 2))
//        let newPosition = SCNVector3(
//            currentPosition.x + currentPosition.x * distance / 700,
//            currentPosition.y + currentPosition.y * distance / 700,
//            currentPosition.z - distance
//        )
//
//        node.position = newPosition
//
//        if gestureRecognizer.state == .ended {
//            node = SCNNode()
//        }
//    }



    // 휴지통 아이콘 롱프레스 이벤트 핸들러
        @objc func deleteObject(_ gestureRecognizer: UILongPressGestureRecognizer) {
            if gestureRecognizer.state == .began {
                let location = gestureRecognizer.location(in: arView)
                let hitTestResults = arView?.hitTest(location, options: [:])

                if let node = hitTestResults?.first?.node {
                    node.removeFromParentNode()
                }
            }
        }
    
    private func registerGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        
        self.arView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    var tapCount = 0 // tap count 저장용 변수

    
    // objc를 붙이면 붙여진 swift 코드를 objective-c 에서도 사용할 수 있다는 뜻
    @objc func tapped(recognizer : UITapGestureRecognizer){
        let arView = recognizer.view as! SCNView
        // tapGestureRecognizer를 받은 뷰가 SceneKitView라고 캐스팅한다.
        
        let touchLocation : CGPoint = recognizer.location(in : arView)
        // 해당 뷰 (sceneView) 에서 정확히 어디를 터치했는지를 판단한다.
        
        let hitResults : [SCNHitTestResult] = arView.hitTest(touchLocation, options: [:])
        // 해당 부분의 터치와 맞닿은 virtual object들을 반환한다.
        // .hitTest는 특정 포인트를 첫번째 parameter로 받아서 해당 부분의 터치와 맞닿은 virtual object들을 반환하는 함수
        // 두번째인 options는 search에 영향을 끼치는데 SCNHitTestOption으로는 backFaceCulling, boundingBoxOnly, categoryBitMask, clipToZRange 등 다양하다.
        // let node = hitReults[0].node
        
        var movingState: MovingState = [MovingState.jump, MovingState.rotate, MovingState.rattle, MovingState.movingBack, MovingState.makeBig][Int.random(in: 0..<5)]
        
        
        if !hitResults.isEmpty{
            let node = hitResults[0].node
            // 만약에 터치 결과가 비어있지 않다면, 무언가를 터치했다는 말이므로 다음과 같이 노드를 꺼낸다.
            
            tapCount += 1 // tap이 일어날 때마다 count 증가
                    
            if tapCount >= 50 {
                // 50번째 tap부터 특정 액션 실행
                let fadeOutAction = SCNAction.fadeOut(duration: 1.0)
                    node.runAction(fadeOutAction)
                
                }
            
            switch movingState {
                case .rotate:
//                    // jump 단계 움직임 삭제
                    node.removeAction(forKey: "jump")
                    
//                    // rotate 단계 움직임 적용
//                    let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 1.0) // 1초 동안 y축을 기준으로 180도 회전하는 액션
//                    let repeatAction = SCNAction.repeatForever(rotateAction) // 액션을 무한 반복하는 액션
//                    node.runAction(repeatAction, forKey: "rotate") // 해당 노드에 액션을 적용하고, key 값을 지정해주어 나중에 해당 액션을 제거할 때 사용할 수 있도록 합니다.
                    

                    let jump = SCNAction.sequence([SCNAction.moveBy(x: 0, y: 0.1, z: 0, duration: 0.5), SCNAction.moveBy(x: 0, y: -0.1, z: 0, duration: 0.5)])
                    let moveForward = SCNAction.moveBy(x: 0, y: 0, z: -1, duration: 1.0)
                    let groupAction = SCNAction.group([jump, moveForward])
                    let repeatAction = SCNAction.repeatForever(groupAction)

                    node.runAction(repeatAction)
                    
                    
//                    movingState = .rotate
                case .rattle:
                    // rotate 단계 움직임 삭제
//                    node.removeAction(forKey: "rotate")
                    node.removeAction(forKey: "jumpAction")

                    
                    // rattle 단계 움직임 적용
                    let rotateAction = SCNAction.rotateBy(x: 0, y: 0, z: CGFloat(Float.pi / 6), duration: 1.0)
                    node.runAction(SCNAction.repeatForever(rotateAction))

//                    let fadeOutAction = SCNAction.fadeOut(duration: 1.0)
//                    node.runAction(fadeOutAction)
//                    movingState = .rattle
                case .makeBig:
                    node.removeAction(forKey: "rattle")

                    let scaleAction = SCNAction.scale(by: 3, duration: 1.0) // 1초 동안 크기를 3배로 확대하는 액션
                    node.runAction(scaleAction)

                case .movingBack:
                    node.removeAction(forKey: "scale")
                    let moveAction = SCNAction.moveBy(x: 0, y: 0, z: -0.2, duration: 1.0)
                    node.runAction(moveAction)
                    
                    
                case .jump:
                    // rattle 단계 움직임 삭제
                    node.removeAction(forKey: "moveAction")
                    
//                    node.removeAction(forKey: "fadeOut")

                    
                    // jump 단계 움직임 적용
                    node.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                    node.physicsBody?.isAffectedByGravity = false
                    node.physicsBody?.damping = 0.0
                    
                    let jumpHeight: Float = 0.03
                    let jumpDuration: TimeInterval = 0.6
                    
                    let jumpAction = SCNAction.sequence([
                        SCNAction.moveBy(x: 0, y: CGFloat(jumpHeight), z: 0, duration: jumpDuration/2),
                        SCNAction.moveBy(x: 0, y: CGFloat(-jumpHeight), z: 0, duration: jumpDuration/2)
                    ])
                    
                    let repeatAction = SCNAction.repeatForever(jumpAction)
                    node.runAction(repeatAction, forKey: "jump")
                    
//                    movingState = .rotate
                    
                default:
                    _ = 0
                    
            }
            
            
            //
            //            let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 1.0) // 1초 동안 y축을 기준으로 180도 회전하는 액션
            //            let repeatAction = SCNAction.repeatForever(rotateAction) // 액션을 무한 반복하는 액션
            //            node.runAction(repeatAction, forKey: "rotate") // 해당 노드에 액션을 적용하고, key 값을 지정해주어 나중에 해당 액션을 제거할 때 사용할 수 있도록 합니다.
            //
            //
            
            
            
            
        }
    }
    
    
    
    
    
    // 중력 0으로 설정
    //            node.physicsBody?.isAffectedByGravity = false
    
    // 앞으로 움직이는 힘 추가
    //            let forceDirection = SCNVector3(0, 0, -10)
    //            let forceMagnitude: CGFloat = 10.0
    ////            let force = forceDirection * forceMagnitude
    //            node.physicsBody?.applyForce(forceDirection, asImpulse: false)
    //
    
    
    
    
    //
    
    
    
    
    
    func updateStarNodes(with item: Item, in arView: ARSCNView) -> SCNNode {
        let imageURL = item.url // Extract the filename from the URL
        
        let point = CGPoint.init(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.5)
        let hitResults = arView.hitTest(point, options: nil)
        
        let starNode = createStarNode(with: item.pointArray, imageURL: imageURL) // Create a star node
        
        if let hitResult = hitResults.first {
            
            // Add a new node at the touch location
            starNode.position = hitResult.localCoordinates
            starNode.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
            
            // 사용자의 현재 위치와 방향을 가져옴
            guard let currentFrame = arView.session.currentFrame else {
                return SCNNode()
            }

            // starNode를 사용자를 바라보는 방향으로 회전시킴
            starNode.eulerAngles.y = currentFrame.camera.eulerAngles.y


            print("starNode.position: \(starNode.position)")
            arView.scene.rootNode.addChildNode(starNode)
        }
        
        
        
        
        return starNode // Return the array of star nodes
    }
    
    // 화면 프레임마다 호출되는 함수
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if let arView = arView, let context = context {
            if Coordinator.summonTrigger {
                //                print("summonTrigger is true")
                if Coordinator.scnNodeArray.count < Coordinator.itemPlanArray.count {
                    //                    print("the two arrays have different counts")
                    Coordinator.summonTrigger = false
                    let newStarNode = context.coordinator.updateStarNodes(with: Coordinator.itemPlanArray.last!, in: arView)
                    //                    print("newStarNode: \(newStarNode)")
                    // Use the DispatchQueue to append the new node
                    Coordinator.scnNodeQueue.async(flags: .barrier) {
                        Coordinator.scnNodeArray.append(newStarNode)
                        //                        print("Coordinator.scnNodeArray.count: \(Coordinator.scnNodeArray.count)")
                    }
                }
            }
        }
    }
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        // 필요한 경우 구현: AR 앵커가 추가되었을 때 호출되는 메소드
    }
}
