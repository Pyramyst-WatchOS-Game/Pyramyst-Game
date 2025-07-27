//
//  GameOverScene.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 27/07/25.
//

import Foundation
import SpriteKit
import SwiftUI
import WatchKit

class GameOverScene: SKScene {
    var onFinishedCollapse: (() -> Void)?
    
    override func sceneDidLoad() {
        backgroundColor = .black
        
        // Tambah tembok
        let wall = SKSpriteNode(color: .gray, size: CGSize(width: 100, height: 20))
        wall.name = "wall_gameover"
        wall.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(wall)
        
        // Tambah label Game Over
        let gameOverLabel = SKLabelNode(text: "Dih kalah awokawok..")
        gameOverLabel.fontSize = 18
        gameOverLabel.fontColor = .white
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/2 + 30)
        addChild(gameOverLabel)
        
        // Trigger animasi tembok jatuh setelah scene muncul
        run(SKAction.sequence([
            SKAction.wait(forDuration: 0.3),
            SKAction.run { [weak self] in self?.collapseWall() }
        ]))
    }
    
    private func collapseWall() {
        guard let wall = childNode(withName: "wall_gameover") else { return }

        // Tambahkan efek rotasi + jatuh + fade
        let collapseAnimation = SKAction.group([
            SKAction.rotate(byAngle: .pi / 2, duration: 0.4),
            SKAction.moveBy(x: 0, y: -60, duration: 0.4),
            SKAction.fadeOut(withDuration: 0.4)
        ])
        
        let sequence = SKAction.sequence([
            collapseAnimation,
            SKAction.removeFromParent()
        ])
        
        wall.run(sequence)

        // Getar saat runtuh
        WKInterfaceDevice.current().play(.failure)

        // Tampilkan modal 1 detik setelah tembok hilang
        run(SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            SKAction.run { [weak self] in
                self?.onFinishedCollapse?()
            }
        ]))
    }
}

