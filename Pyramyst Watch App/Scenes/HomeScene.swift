//
//  HomeScene.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 28/07/25.
//

import SpriteKit
import SwiftUI
import WatchKit

class HomeScene: SKScene {
    
    private var playButton: SKSpriteNode?
    private var collectiblesButton: SKSpriteNode?
    private var logoSprite: SKSpriteNode?
    
    var onPlayTapped: (() -> Void)?
    var onCollectiblesTapped: (() -> Void)?
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        backgroundColor = .black
        
        setupUI()
    }
    
    private func setupUI() {
        let logoTexture = SKTexture(imageNamed: "pyramystLogo")
        logoSprite = SKSpriteNode(texture: logoTexture)
        logoSprite?.name = "logo"
        logoSprite?.size = CGSize(width: size.width * 0.6, height: size.width * 0.3)
        logoSprite?.position = CGPoint(x: size.width/2, y: size.height * 0.7)
        logoSprite?.zPosition = 1
        if let logo = logoSprite {
            addChild(logo)
        }
        
        let playButtonTexture = SKTexture(imageNamed: "playButton")
        playButton = SKSpriteNode(texture: playButtonTexture)
        playButton?.name = "playButton"
        playButton?.size = CGSize(width: size.width * 0.7, height: size.width * 0.2)
        playButton?.position = CGPoint(x: size.width/2, y: size.height * 0.30)
        playButton?.zPosition = 1
        if let button = playButton {
            addChild(button)
        }
        
        let collectiblesButtonTexture = SKTexture(imageNamed: "collectionButton")
        collectiblesButton = SKSpriteNode(texture: collectiblesButtonTexture)
        collectiblesButton?.name = "collectionButton"
        collectiblesButton?.size = CGSize(width: size.width * 0.2, height: size.width * 0.2) 
        collectiblesButton?.position = CGPoint(x: size.width * 0.15, y: size.height * 0.70)
        collectiblesButton?.zPosition = 1
        if let button = collectiblesButton {
            addChild(button)
        }
    }
    
    func handleTap(at location: CGPoint) {
        print("Scene received tap at: \(location)")
        print("Collection button position: \(collectiblesButton?.position ?? CGPoint.zero)")
        print("Collection button size: \(collectiblesButton?.size ?? CGSize.zero)")
        
        let touchedNode = atPoint(location)
        print("Touched node: \(touchedNode.name ?? "nil")")
        switch touchedNode.name {
        case "playButton":
            WKInterfaceDevice.current().play(.click)
            
            let clickedTexture = SKTexture(imageNamed: "playButtonClicked")
            playButton?.texture = clickedTexture
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                let normalTexture = SKTexture(imageNamed: "playButton")
                self.playButton?.texture = normalTexture
            }
            
            onPlayTapped?()
            
        case "collectionButton":
            WKInterfaceDevice.current().play(.click)
            
            let clickedTexture = SKTexture(imageNamed: "collectionButtonClicked")
            collectiblesButton?.texture = clickedTexture
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                let normalTexture = SKTexture(imageNamed: "collectionButton")
                self.collectiblesButton?.texture = normalTexture
            }
            
            onCollectiblesTapped?()
            
        default:
            break
        }
    }
}
