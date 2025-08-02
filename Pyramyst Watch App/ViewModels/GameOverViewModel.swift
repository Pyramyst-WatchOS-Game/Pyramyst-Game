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
    
    var manager = UserDefaultManager()
    
    let gameOverScene: GameOverScene
    
    init() {
        let screenBounds = WKInterfaceDevice.current().screenBounds
        let screenSize = CGSize(width: screenBounds.width, height: screenBounds.height)
        
        let gameOverScene = GameOverScene(size: screenSize)
        gameOverScene.scaleMode = .aspectFill
        
        self.gameOverScene = gameOverScene
        
        DispatchQueue.main.async { [weak self] in
            gameOverScene.onFinishedCollapse = {
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
        manager.resetLevel()
    }
}
