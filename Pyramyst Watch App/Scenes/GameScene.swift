//
//  GameScene.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 24/07/25.
//

import SpriteKit
import SwiftUI
import WatchKit

class GameScene: SKScene {
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        backgroundColor = .red
        let dialTexture = SKTexture(imageNamed: "dial")
        let dial = SKSpriteNode(texture: dialTexture)
        dial.name = "dial"
        dial.size = CGSize(width: size.width * 0.8, height: size.width * 0.8)
        dial.position = CGPoint(x: size.width/2, y: size.height/2)
        
        let rotationLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        rotationLabel.name = "rotationLabel"
        rotationLabel.fontSize = 20
        rotationLabel.fontColor = .white
        rotationLabel.position = CGPoint(x: size.width/2, y: size.height * 0.15)
        rotationLabel.text = "0"                    // nilai awal
        addChild(rotationLabel)
        
        
        addChild(dial)
        
        addTicks(count: 50,
                 innerRadius: size.width * 0.35,
                 outerRadius: size.width * 0.40)
    }
    
    private func addTicks(count: Int = 50,
                          innerRadius: CGFloat = 80,
                          outerRadius: CGFloat = 90) {
        let center = CGPoint(x: size.width/2, y: size.height/2)
        for i in 0..<count {
            let angle = CGFloat(i) / CGFloat(count) * 2 * .pi
            // inner & outer point
            let p1 = CGPoint(x: center.x + cos(angle)*innerRadius,
                             y: center.y + sin(angle)*innerRadius)
            let p2 = CGPoint(x: center.x + cos(angle)*outerRadius,
                             y: center.y + sin(angle)*outerRadius)
            // path dan shape node
            let path = CGMutablePath()
            path.move(to: p1)
            path.addLine(to: p2)
            let tick = SKShapeNode(path: path)
            tick.strokeColor = .white
            tick.lineWidth = 1
            addChild(tick)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    
}
