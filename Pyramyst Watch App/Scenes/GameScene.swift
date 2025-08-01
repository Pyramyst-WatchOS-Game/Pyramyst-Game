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
    
    private var infoLabel: SKLabelNode?
    private var timerLabel: SKLabelNode?
    
    private var hourglassIcon: SKSpriteNode!
    private var barOutline: SKShapeNode!
    private var barFill: SKSpriteNode!
    
    var totalTime: TimeInterval = 20
    
    private var dialCompletionStates: [Int: Bool] = [1: false, 2: false, 3: false]
    private var dialCompletedRotations: [Int: CGFloat] = [:]
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        backgroundColor = .black
        setupBackground()
        
        let dial0Texture = SKTexture(imageNamed: "dial0")
        let dial0 = SKSpriteNode(texture: dial0Texture)
        dial0.name = "dial0"
        dial0.size = CGSize(width: size.width * 0.2, height: size.width * 0.2)
        dial0.position = CGPoint(x: size.width/2, y: size.height/2)
        dial0.zPosition = 5
        dial0.alpha = 1.0
        addChild(dial0)
        
        let dial1Texture = SKTexture(imageNamed: "dial1")
        let dial1 = SKSpriteNode(texture: dial1Texture)
        dial1.name = "dial1"
        dial1.size = CGSize(width: size.width * 0.35, height: size.width * 0.35)
        dial1.position = CGPoint(x: size.width/2, y: size.height/2)
        dial1.zPosition = 3
        dial1.alpha = 1.0
        addChild(dial1)
        
        let dial2Texture = SKTexture(imageNamed: "dial2")
        let dial2 = SKSpriteNode(texture: dial2Texture)
        dial2.name = "dial2"
        dial2.size = CGSize(width: size.width * 0.55, height: size.width * 0.55)
        dial2.position = CGPoint(x: size.width/2, y: size.height/2)
        dial2.zPosition = 2
        dial2.alpha = 1.0
        addChild(dial2)
        
        let dial3Texture = SKTexture(imageNamed: "dial3")
        let dial3 = SKSpriteNode(texture: dial3Texture)
        dial3.name = "dial3"
        dial3.size = CGSize(width: size.width * 0.80, height: size.width * 0.80)
        dial3.position = CGPoint(x: size.width/2, y: size.height/2)
        dial3.zPosition = 1
        dial3.alpha = 1.0
        addChild(dial3)
        
        let correctSignTexture = SKTexture(imageNamed: "correctSign2")
        let correctSign = SKSpriteNode(texture: correctSignTexture)
        correctSign.name = "correctSign"
        correctSign.size = CGSize(width: size.width * 0.8, height: size.width * 0.8)
        correctSign.position = CGPoint(x: size.width/2, y: size.height/2)
        correctSign.zPosition = 200
        correctSign.alpha = 0.0
        addChild(correctSign)
        
        infoLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        infoLabel?.name = "infoLabel"
        infoLabel?.fontSize = 12
        infoLabel?.fontColor = .white
        infoLabel?.position = CGPoint(x: size.width/2, y: size.height * 0.8)
        infoLabel?.text = "Dial 1 - Code: 0"
        infoLabel?.zPosition = 4
        if infoLabel != nil {
            //            addChild(label)
        }
        
        timerLabel = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        timerLabel?.name = "timerLabel"
        timerLabel?.fontSize = 14
        timerLabel?.fontColor = .red
        timerLabel?.position = CGPoint(x: size.width/2, y: size.height * 0.15)
        timerLabel?.text = "20.0"
        timerLabel?.zPosition = 4
        if timerLabel != nil {
            //            addChild(label)
        }
        
        setupTimerBar()
    }
    
    private func setupBackground() {
        
        let tex = SKTexture(imageNamed: "gameBackground")
        let backgroundNode = SKSpriteNode(texture: tex)
        
        backgroundNode.anchorPoint = .zero
        backgroundNode.position    = .zero
        
        backgroundNode.zPosition   = -1
        
        backgroundNode.size       = size
        
        addChild(backgroundNode)
    }
    
    private func setupTimerBar() {
        let margin: CGFloat = 15
        
        let iconSize = CGSize(width: 25, height: 25)
        hourglassIcon = SKSpriteNode(imageNamed: "hourglassIcon")
        hourglassIcon.size = iconSize
        hourglassIcon.position = CGPoint(
            x: margin + iconSize.width/2,
            y: size.height - margin - iconSize.height/2
        )
        hourglassIcon.zPosition = 100
        addChild(hourglassIcon)
        
        let barHeight: CGFloat = 8
        let desiredBarWidth: CGFloat = size.width * 0.3
        
        let backgroundWidth = iconSize.width + desiredBarWidth
        let backgroundHeight = max(iconSize.height, barHeight)
        
        let timerBackground = SKSpriteNode(imageNamed: "timerBackground")
        timerBackground.size = CGSize(width: backgroundWidth, height: backgroundHeight)
        
        let spaceBetweenIconAndBar: CGFloat = -13
        let backgroundCenterX = hourglassIcon.position.x + (backgroundWidth - iconSize.width) / 2
        timerBackground.position = CGPoint(
            x: backgroundCenterX,
            y: hourglassIcon.position.y
        )
        timerBackground.zPosition = 80
        addChild(timerBackground)
        
        barOutline = SKShapeNode(
            rectOf: CGSize(width: desiredBarWidth, height: barHeight),
            cornerRadius: barHeight/3
        )
        barOutline.lineWidth = 1.5
        barOutline.strokeColor = UIColor(named: "outlineColor") ?? .orange
        barOutline.fillColor = .clear
        
        barOutline.position = CGPoint(
            x: hourglassIcon.position.x + iconSize.width/2 + spaceBetweenIconAndBar + desiredBarWidth/2,
            y: hourglassIcon.position.y
        )
        barOutline.zPosition = 90
        addChild(barOutline)
        
        barFill = SKSpriteNode(
            color: UIColor(named: "sandColor") ?? .yellow,
            size: CGSize(width: desiredBarWidth, height: barHeight)
        )
        barFill.anchorPoint = CGPoint(x: 0, y: 0.5)
        barFill.position = CGPoint(
            x: barOutline.position.x - desiredBarWidth/2,
            y: hourglassIcon.position.y
        )
        barFill.zPosition = 95
        addChild(barFill)
    }
    
    func updateGameInfo(currentCircle: Int,
                        targetCode: Int,
                        timeRemaining: Double) {
        infoLabel?.text  = "Dial \(currentCircle) - Target: \(targetCode)"
        timerLabel?.text = String(format: "%.1f", max(0, timeRemaining))
        
        let frac = CGFloat(max(min(timeRemaining/totalTime, 1), 0))
        barFill.xScale = frac
        
        if frac <= 0.7 {
            if frac <= 0.5 {
                barFill.color = UIColor.red
            } else {
                barFill.color = UIColor.orange
            }
        } else {
            barFill.color = UIColor(named: "sandColor") ?? .yellow
        }
    }
    
    func updateDialPosition(circle: Int, position: Int, isCorrect: Bool, isNearRange: Bool) {
        let dialName = "dial\(circle)"
        _ = childNode(withName: dialName)
        
        backgroundColor = .black
        
        if let correctSign = childNode(withName: "correctSign") as? SKSpriteNode {
            correctSign.removeAllActions()
            correctSign.setScale(1.0)
        }
        
        if isCorrect {
            if let correctSign = childNode(withName: "correctSign") as? SKSpriteNode {
                correctSign.removeAllActions()
                
                correctSign.alpha = 1.0
                correctSign.setScale(1.0)
                
                let scaleUp = SKAction.scale(to: 1.2, duration: 0.6)
                scaleUp.timingMode = .easeInEaseOut
                
                let scaleDown = SKAction.scale(to: 1.0, duration: 0.6)
                scaleDown.timingMode = .easeInEaseOut
                
                let pulseSequence = SKAction.sequence([scaleUp, scaleDown])
                let repeatPulse = SKAction.repeatForever(pulseSequence)
                
                let fadeOut = SKAction.fadeAlpha(to: 0.7, duration: 0.6)
                fadeOut.timingMode = .easeInEaseOut
                
                let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.6)
                fadeIn.timingMode = .easeInEaseOut
                
                let glowSequence = SKAction.sequence([fadeOut, fadeIn])
                let repeatGlow = SKAction.repeatForever(glowSequence)
                
                let combinedAnimation = SKAction.group([repeatPulse, repeatGlow])
                correctSign.run(combinedAnimation, withKey: "correctSignAnimation")
            }
        } else if isNearRange {
            if let correctSign = childNode(withName: "correctSign") as? SKSpriteNode {
                correctSign.removeAction(forKey: "correctSignAnimation")
                correctSign.alpha = 0.2
            }
        } else {
            
            if let correctSign = childNode(withName: "correctSign") as? SKSpriteNode {
                correctSign.removeAction(forKey: "correctSignAnimation")
                correctSign.alpha = 0.0
            }
        }
    }
    
    func removeCorrectSign() {
        self.removeChildren(in:
            self.children.filter { $0.name == "correctSign" }
        )
    }
    
    func markDialAsCompleted(circle: Int, finalRotation: CGFloat) {
        dialCompletionStates[circle] = true
        dialCompletedRotations[circle] = finalRotation
        
        let dialName = "dial\(circle)"
        if let dial = childNode(withName: dialName) as? SKSpriteNode {
            let completedTextureName = "dialCompleted\(circle)"
            let completedTexture = SKTexture(imageNamed: completedTextureName)
            dial.texture = completedTexture
            
            dial.zRotation = finalRotation
            
            dial.alpha = 0.9
        }
    }
    
    func updateDialRotation(circle: Int, rotation: CGFloat) {
        if dialCompletionStates[circle] == true {
            return
        }
        
        let dialName = "dial\(circle)"
        if let dial = childNode(withName: dialName) {
            dial.zRotation = rotation
        }
    }
    
    func isDialCompleted(circle: Int) -> Bool {
        return dialCompletionStates[circle] ?? false
    }
    
    func resetAllDials() {
        dialCompletionStates = [1: false, 2: false, 3: false]
        dialCompletedRotations = [:]
        
        for circle in 1...3 {
            let dialName = "dial\(circle)"
            if let dial = childNode(withName: dialName) as? SKSpriteNode {
                let normalTexture = SKTexture(imageNamed: "dial\(circle)")
                dial.texture = normalTexture
                dial.alpha = 1.0
                dial.zRotation = 0.0
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
