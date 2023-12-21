//
//  ARViewDrawingModel.swift
//  MC2-TEAM10-BURIBURI
//
//  Created by Wonil Lee on 12/21/23.
//

import Foundation

final class ARViewDrawingModel: ObservableObject {
    @Published var arViewIsDrawn = true

    @MainActor
    func setARViewIsDrawnTrue() {
        arViewIsDrawn = true
    }
    @MainActor
    func setARViewIsDrawnFalse() {
        arViewIsDrawn = false
    }
    
    func resetARView() {
        Task(priority: .userInitiated) {
            await setARViewIsDrawnFalse()
            do {
                try await Task.sleep(nanoseconds: 10_000_000)
            } catch {
                print("error sleeping: \(error.localizedDescription)")
            }
            await setARViewIsDrawnTrue()
        }
    }

    func hideARView() {
        Task {
            await setARViewIsDrawnFalse()
        }
    }
}
