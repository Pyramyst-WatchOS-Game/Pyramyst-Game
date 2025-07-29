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
    
    private let brickWidth: CGFloat = 50
    private let brickHeight: CGFloat = 50
    private let totalCols = 6
    private let totalRows = 7
    private let offsetX: CGFloat = 15
    private let rowSpacing: CGFloat = 5

    override func sceneDidLoad() {
        backgroundColor = .black
        createFallingBricks()
        scheduleFinishCallback()
    }

    private func createFallingBricks() {
        for row in 0..<totalRows {
            let isEvenRow = row % 2 == 0
            let extraCol = isEvenRow ? 1 : 0

            for col in (-extraCol)..<totalCols {
                let brick = makeBrick(forRow: row, col: col, isEvenRow: isEvenRow)
                addChild(brick)
                runBrickAnimation(brick, row: row)
            }
        }
    }

    private func makeBrick(forRow row: Int, col: Int, isEvenRow: Bool) -> SKSpriteNode {
        let brickIndex = Int.random(in: 1...5)
        let brickName = "brick\(brickIndex)"
        let brick = SKSpriteNode(imageNamed: brickName)
        brick.size = CGSize(width: brickWidth, height: brickHeight)
        brick.alpha = 0
        brick.name = "brick_\(row)_\(col)"

        let xOffset = isEvenRow ? offsetX : -offsetX
        let targetX = CGFloat(col) * brickWidth + brickWidth / 2 + xOffset
        let targetY = CGFloat(row) * (brickHeight - rowSpacing) + brickHeight / 2

        // Mulai dari atas layar
        brick.position = CGPoint(x: targetX, y: size.height + brickHeight)
        brick.userData = ["targetY": targetY]
        return brick
    }

    private func runBrickAnimation(_ brick: SKSpriteNode, row: Int) {
        guard let targetY = brick.userData?["targetY"] as? CGFloat else { return }

        let delay = 0.2 * Double(row)

        let moveDown = SKAction.moveTo(y: targetY, duration: 0.5)
        moveDown.timingMode = .easeInEaseOut

        let fadeIn = SKAction.fadeIn(withDuration: 0.2)
        let group = SKAction.group([moveDown, fadeIn])

        let shake = SKAction.sequence([
            SKAction.moveBy(x: 3, y: 0, duration: 0.05),
            SKAction.moveBy(x: -6, y: 0, duration: 0.05),
            SKAction.moveBy(x: 3, y: 0, duration: 0.05)
        ])

        let sequence = SKAction.sequence([
            SKAction.wait(forDuration: delay),
            group,
            shake
        ])

        brick.run(sequence)
    }

    private func scheduleFinishCallback() {
        let totalDelay = 0.3 * Double(totalRows) + 0.5
        run(SKAction.sequence([
            SKAction.wait(forDuration: totalDelay),
            SKAction.run {
                WKInterfaceDevice.current().play(.click)
                self.onFinishedCollapse?()
            }
        ]))
    }
}
