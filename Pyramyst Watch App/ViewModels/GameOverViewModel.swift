//
//  GameOverViewModel.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 27/07/25.
//

import Foundation
import SpriteKit
import WatchKit

class GameOverViewModel: ObservableObject {
    @Published var showGameOverModal: Bool = false
    let gameOverScene: GameOverScene
    
    init() {
        let size = CGSize(width: 184, height: 224)
        let scene = GameOverScene(size: size)
        scene.scaleMode = .resizeFill
        
        self.gameOverScene = scene
        
        // set closure 
        DispatchQueue.main.async { [weak self] in
            scene.onFinishedCollapse = {
                self?.showGameOverModal = true
            }
        }
    }
    
    
    func triggerModal() {
        showGameOverModal.toggle()
    }
    
    func resetModal() {
        showGameOverModal = false
    }
    
    func resetGame() {
    }
    
    func restartGame() {
        
    }
}
