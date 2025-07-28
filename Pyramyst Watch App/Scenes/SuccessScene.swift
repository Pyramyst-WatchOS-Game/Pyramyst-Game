//
//  SuccessScene.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 28/07/25.
//

import Foundation
import SpriteKit

class SuccessScene: SKScene {

    private let chest = SKSpriteNode(imageNamed: "chest")
    private var treasure: SKSpriteNode!
    private var treasureLabel: SKLabelNode!

    private let homeButton = SKLabelNode(text: "Home")
    private let nextButton = SKLabelNode(text: "Next")

    // Treasure image name dan label text sebagai properti dinamis
    private let treasureImageName: String
    private let treasureText: String

    // Custom initializer untuk terima data dinamis
    init(size: CGSize, treasureImageName: String, treasureText: String) {
        self.treasureImageName = treasureImageName
        self.treasureText = treasureText
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func sceneDidLoad() {
        setupScene()
        setupChest()
        setupTreasure()
        setupLabel()
        setupHomeButton()
        setupNextButton()
        runAnimations()
    }

    // MARK: - Setup Methods

    private func setupScene() {
        backgroundColor = .black
    }

    private func setupChest() {
        let textureSize = chest.texture?.size() ?? .zero
        let xScale = size.width / textureSize.width
        let yScale = size.height / textureSize.height
        let scale = min(xScale, yScale)

        chest.setScale(scale)
        chest.position = CGPoint(x: size.width / 2, y: size.height / 2)
        chest.zPosition = 1

        addChild(chest)
    }

    private func setupTreasure() {
        treasure = SKSpriteNode(imageNamed: treasureImageName)
        treasure.size = CGSize(width: 50, height: 50)
        treasure.position = CGPoint(x: size.width / 2, y: size.height / 2)
        treasure.setScale(1.0)
        treasure.zPosition = 2

        addChild(treasure)
    }

    private func setupLabel() {
        treasureLabel = SKLabelNode(text: treasureText)
        treasureLabel.fontSize = 16
        treasureLabel.fontColor = .white
        treasureLabel.position = CGPoint(x: size.width / 2, y: size.height / 2 - 30)
        treasureLabel.zPosition = 3
        treasureLabel.alpha = 0

        addChild(treasureLabel)
    }

    private func setupHomeButton() {
        homeButton.name = "homeButton"
        homeButton.fontSize = 18
        homeButton.fontColor = .white
        homeButton.position = CGPoint(x: 50, y: size.height / 2 - 70)
        homeButton.zPosition = 11
        homeButton.alpha = 0

        let homeBg = SKShapeNode(rectOf: CGSize(width: 80, height: 30), cornerRadius: 20)
        homeBg.fillColor = .gray.withAlphaComponent(0.6)
        homeBg.position = homeButton.position
        homeBg.zPosition = 10
        homeBg.alpha = 0

        addChild(homeBg)
        addChild(homeButton)
    }

    private func setupNextButton() {
        nextButton.name = "nextButton"
        nextButton.fontSize = 18
        nextButton.fontColor = .white
        nextButton.position = CGPoint(x: 150, y: size.height / 2 - 70)
        nextButton.zPosition = 11
        nextButton.alpha = 0

        let nextBg = SKShapeNode(rectOf: CGSize(width: 80, height: 30), cornerRadius: 20)
        nextBg.fillColor = .gray.withAlphaComponent(0.6)
        nextBg.position = nextButton.position
        nextBg.zPosition = 10
        nextBg.alpha = 0

        addChild(nextBg)
        addChild(nextButton)
    }

    // MARK: - Animation Sequence
    private func runAnimations() {
        let wait = SKAction.wait(forDuration: 1.0)

        let chestMoveDown = SKAction.moveBy(x: 0, y: -200, duration: 1.5)
        chestMoveDown.timingMode = .easeInEaseOut
        chest.run(SKAction.sequence([wait, chestMoveDown]))

        let rotate = SKAction.rotate(byAngle: .pi * 2, duration: 0.5)

        let scaleUp = SKAction.scale(to: 3, duration: 0.5)
        let moveUp = SKAction.moveBy(x: 0, y: 50, duration: 0.5)
        scaleUp.timingMode = .easeOut
        moveUp.timingMode = .easeOut
        let growAndMove = SKAction.group([scaleUp, moveUp])

        let treasureSequence = SKAction.sequence([wait, rotate, growAndMove])
        treasure.run(treasureSequence)

        let labelDelay = SKAction.wait(forDuration: 2.0)
        let fadeInLabel = SKAction.fadeIn(withDuration: 0.5)
        treasureLabel.run(SKAction.sequence([labelDelay, fadeInLabel]))

        let buttonDelay = SKAction.wait(forDuration: 2.5)
        let fadeInButton = SKAction.fadeIn(withDuration: 0.5)
        homeButton.run(SKAction.sequence([buttonDelay, fadeInButton]))
        nextButton.run(SKAction.sequence([buttonDelay, fadeInButton]))
    }
}
