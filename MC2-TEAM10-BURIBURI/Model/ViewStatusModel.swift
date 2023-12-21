//
//  ViewStatusModel.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by Wonil Lee on 12/21/23.
//

import Foundation

final class HeavyViewStatusModel: ObservableObject {
    @Published var tutorialCameraViewIsDrawn = true
    @Published var cameraViewIsDrawn = true
    @Published var arViewIsDrawn = true
    
    @MainActor
    func setTutorialCameraViewIsDrawnTrue() {
        tutorialCameraViewIsDrawn = true
    }
    @MainActor
    func setTutorialCameraViewIsDrawnFalse() {
        tutorialCameraViewIsDrawn = false
    }
    @MainActor
    func setCameraViewIsDrawnTrue() {
        cameraViewIsDrawn = true
    }
    @MainActor
    func setCameraViewIsDrawnFalse() {
        cameraViewIsDrawn = false
    }
    @MainActor
    func setARViewIsDrawnTrue() {
        arViewIsDrawn = true
    }
    @MainActor
    func setARViewIsDrawnFalse() {
        arViewIsDrawn = false
    }
    
    func resetTutorialCameraView() {
        Task(priority: .userInitiated) {
            await setTutorialCameraViewIsDrawnFalse()
            do {
                try await Task.sleep(nanoseconds: 100_000_000)
            } catch {
                print("error sleeping: \(error.localizedDescription)")
            }
            await setTutorialCameraViewIsDrawnTrue()
        }
    }
    
    func resetCameraView() {
        Task(priority: .userInitiated) {
            await setCameraViewIsDrawnFalse()
            do {
                try await Task.sleep(nanoseconds: 100_000_000)
            } catch {
                print("error sleeping: \(error.localizedDescription)")
            }
            await setCameraViewIsDrawnTrue()
        }
    }
    
    func resetARView() {
        Task(priority: .userInitiated) {
            await setARViewIsDrawnFalse()
            do {
                try await Task.sleep(nanoseconds: 100_000_000)
            } catch {
                print("error sleeping: \(error.localizedDescription)")
            }
            await setARViewIsDrawnTrue()
        }
    }
    
    func resetAllHeavyViews() {
        Task(priority: .userInitiated) {
            await setTutorialCameraViewIsDrawnFalse()
            await setCameraViewIsDrawnFalse()
            await setARViewIsDrawnFalse()
            do {
                try await Task.sleep(nanoseconds: 100_000_000)
            } catch {
                print("error sleeping: \(error.localizedDescription)")
            }
            await setTutorialCameraViewIsDrawnTrue()
            await setCameraViewIsDrawnTrue()
            await setARViewIsDrawnTrue()
        }
    }
    
    func hideTutorialCameraView() {
        Task {
            await setTutorialCameraViewIsDrawnFalse()
        }
    }
    
    func hideCameraView() {
        Task {
            await setCameraViewIsDrawnFalse()
        }
    }
    
    func hideARView() {
        Task {
            await setARViewIsDrawnFalse()
        }
    }
}
