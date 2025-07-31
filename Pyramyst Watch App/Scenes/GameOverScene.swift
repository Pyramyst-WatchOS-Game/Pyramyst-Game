//
//  GameOverScene.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 27/07/25.
//

import Foundation
import SpriteKit
import WatchKit

class GameOverScene: SKScene {
    var onFinishedCollapse: (() -> Void)?
    
    private var bricks: [SKSpriteNode] = []
    
    override func sceneDidLoad() {
        backgroundColor = .black
        setupBackground()
        
        let brickWidth: CGFloat = 50
        let brickHeight: CGFloat = 40
        let totalCols = 6
        let totalRows = 7
        let offsetX: CGFloat = 15
        let spacingY: CGFloat = 5
        
        for row in 0..<totalRows {
            let isEvenRow = row % 2 == 0
            let extraCol = isEvenRow ? 1 : 0

            for col in (-extraCol)..<totalCols {
                let brickIndex = Int.random(in: 1...4)
                let brickName = "brick\(brickIndex)"
                let brick = SKSpriteNode(imageNamed: brickName)
                brick.size = CGSize(width: brickWidth, height: brickHeight)

                let posX = CGFloat(col) * brickWidth + brickWidth / 2 + (isEvenRow ? offsetX : -offsetX)
                let posY = CGFloat(row) * (brickHeight - spacingY) + brickHeight / 2

                brick.position = CGPoint(x: posX, y: posY)
                brick.name = "brick_\(row)_\(col)"
            
                brick.setScale(0.0)
                
                addChild(brick)
                bricks.append(brick)

                let scaleUp = SKAction.scale(to: 1.0, duration: 0.8)
                scaleUp.timingMode = .easeOut
                brick.run(scaleUp)
            }
        }

        let collapseDelay = 0.8
        run(SKAction.sequence([
            SKAction.wait(forDuration: collapseDelay),
            SKAction.run { self.startCollapseAnimation() }
        ]))
    }
    
    private func setupBackground() {
       
        let tex = SKTexture(imageNamed: "gameOverBackground")
        let backgroundNode = SKSpriteNode(texture: tex)
        
        backgroundNode.anchorPoint = .zero
        backgroundNode.position    = .zero
        
        backgroundNode.zPosition   = -1
    
        backgroundNode.size       = size
        
        addChild(backgroundNode)
    }
    
    private func startCollapseAnimation() {
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let sortedBricks = bricks.sorted {
            $0.position.distance(to: center) < $1.position.distance(to: center)
        }

        for (index, brick) in sortedBricks.enumerated() {
            let delay = 0.05 * Double(index)
            let fallDistance = -size.height - brick.size.height

            let shake = SKAction.sequence([
                SKAction.moveBy(x: 3, y: 0, duration: 0.03),
                SKAction.moveBy(x: -6, y: 0, duration: 0.03),
                SKAction.moveBy(x: 3, y: 0, duration: 0.03)
            ])

            let fall = SKAction.moveBy(x: 0, y: fallDistance, duration: 0.5)
            fall.timingMode = .easeIn

            let remove = SKAction.run { brick.removeFromParent() }

            var actions: [SKAction] = []
            actions.append(SKAction.wait(forDuration: delay))

            // haptic setiap 5 batu
            if index % 5 == 0 {
                actions.append(SKAction.run {
                    WKInterfaceDevice.current().play(.directionDown)
                })
            }

            actions.append(contentsOf: [shake, fall, remove])

            brick.run(SKAction.sequence(actions))
        }

        let totalDuration = 0.05 * Double(bricks.count) + 0.6
        run(SKAction.sequence([
            SKAction.wait(forDuration: totalDuration),
            SKAction.run {
                WKInterfaceDevice.current().play(.click)
                self.onFinishedCollapse?()
            }
        ]))
    }
}

private extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        let dx = x - point.x
        let dy = y - point.y
        return sqrt(dx * dx + dy * dy)
    }
}
