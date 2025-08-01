//
//  GameViewModel.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 24/07/25.
//

import SpriteKit
import Combine
import WatchKit
final class GameViewModel: ObservableObject {
    @Published var rotation: Double = 0.0
    @Published var gameModel: GamePlayModel
    @Published var timeRemaining: Double = 0
    @Published var isGameCompleted: Bool = false
    @Published var isGameOver: Bool = false
    private var manager = UserDefaultManager.shared
    
    let scene: GameScene
    private var gameTimer: Timer?
    private var hapticTimer: Timer?
    
    private var lastTick = 0
    private var currentHapticState: HapticType?
    
    private var currentMaxTicks: Int {
        switch gameModel.currentCircle {
        case 1: return 50
        case 2: return 75
        case 3: return 100
        default: return 50
        }
    }
    
    private var currentTargetCode: Int {
        switch gameModel.currentCircle {
        case 1: return gameModel.firstCode
        case 2: return gameModel.secondCode
        case 3: return gameModel.thirdCode
        default: return 0
        }
    }
    
    init(gameModel: GamePlayModel) {
        print("🎯 Creating NEW GameViewModel instance: \(UUID())")
        self.gameModel = gameModel
        self.timeRemaining = gameModel.timeLimit
        
        print(gameModel)
        
        let screenBounds = WKInterfaceDevice.current().screenBounds
        let screenSize = CGSize(width: screenBounds.width, height: screenBounds.height)
        
        let lockScene = GameScene(size: screenSize)
        lockScene.scaleMode = .aspectFill
        self.scene = lockScene
        self.scene.totalTime = gameModel.timeLimit
        
        startGame()
    }
    
    private func startGame() {
        updateGameDisplay()
        startTimerIfNeeded()
    }
    
    private func startTimerIfNeeded() {
        gameTimer?.invalidate()
        gameTimer = nil

        let shouldRunTimer = !(manager.getCurrentLevel() == 1 && gameModel.currentCircle == 1)
        
        if shouldRunTimer {
            gameTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                DispatchQueue.main.async {
                    self.timeRemaining -= 0.1
                    self.updateGameDisplay()
                    
                    if self.timeRemaining <= 0 {
                        self.gameOver()
                    }
                }
            }
        }
    }

    private func updateGameDisplay() {
        if let gameScene = scene as? GameScene {
            gameScene.updateGameInfo(
                currentCircle: gameModel.currentCircle,
                targetCode: currentTargetCode,
                timeRemaining: timeRemaining
            )
        }
    }
    
    func updateRotation(to newValue: Double) {
        rotation = newValue
        
        let currentPosition = Int(newValue) % currentMaxTicks
        let isCorrectPosition = currentPosition == currentTargetCode
        
        let isInNearRange = currentPosition >= (currentTargetCode - 2) && currentPosition < currentTargetCode || currentPosition > currentTargetCode && currentPosition <= (currentTargetCode + 2)
        
        if let gameScene = scene as? GameScene {
            gameScene.updateDialPosition(
                circle: gameModel.currentCircle,
                position: currentPosition,
                isCorrect: isCorrectPosition,
                isNearRange: isInNearRange
            )
        }
        
        let angle = (newValue / Double(currentMaxTicks)) * 2 * .pi
        
        if let gameScene = scene as? GameScene {
            gameScene.updateDialRotation(circle: gameModel.currentCircle, rotation: CGFloat(angle))
        }
        
        let tick = currentPosition
        if tick != lastTick {
            let newHapticState: HapticType? = {
                if isCorrectPosition {
                    return .correct
                } else if isInNearRange {
                    return .nearTarget
                } else {
                    return nil
                }
            }()
            
            if currentHapticState != newHapticState {
                stopHapticFeedback()
                
                if let state = newHapticState {
                    startContinuousHaptic(type: state)
                }
                
                currentHapticState = newHapticState
            }
            
            if currentHapticState == nil {
                WKInterfaceDevice.current().play(.click)
            }
            
            lastTick = tick
        }
    }

    private enum HapticType: Equatable {
        case correct
        case nearTarget
    }
    
    private func startContinuousHaptic(type: HapticType) {
        hapticTimer?.invalidate()
        
        hapticTimer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in
            switch type {
            case .correct:
                WKInterfaceDevice.current().play(.stop)
            case .nearTarget:
                WKInterfaceDevice.current().play(.click)
            }
        }
    }
    
    private func stopHapticFeedback() {
        hapticTimer?.invalidate()
        hapticTimer = nil
        currentHapticState = nil
    }
    
    func submitCode() {
        if isGameCompleted || isGameOver {
            return
        }
        
        let currentPosition = Int(rotation) % currentMaxTicks
        
        stopHapticFeedback()
        
        if currentPosition == currentTargetCode {
            let finalAngle = (rotation / Double(currentMaxTicks)) * 2 * .pi
            if let gameScene = scene as? GameScene {
                gameScene.markDialAsCompleted(circle: gameModel.currentCircle, finalRotation: CGFloat(finalAngle))
            }
            
            if gameModel.currentCircle < 3 {
                gameModel.currentCircle += 1
                rotation = 0.0
                updateGameDisplay()
                startTimerIfNeeded()
                if self.gameModel.level >= 10 {
                    increaseTime()
                
                }
                WKInterfaceDevice.current().play(.success)
            } else {
                self.scene.removeCorrectSign()
                gameCompleted()
            }
        } else {
            WKInterfaceDevice.current().play(.failure)
        }
    }
    
    private func increaseTime() {
        self.timeRemaining += 1
    }
    
    private func gameCompleted() {
        print("🎉 Game completed - cleaning up")
        print(manager.getUserLevel())
        stopHapticFeedback()
        gameTimer?.invalidate()
        gameTimer = nil
        isGameCompleted = true
        manager.goToNextLevel()
        WKInterfaceDevice.current().play(.success)
    }
    
    private func gameOver() {
        print("💀 Game over - cleaning up")
        stopHapticFeedback()
        gameTimer?.invalidate()
        gameTimer = nil
        isGameOver = true
        WKInterfaceDevice.current().play(.failure)
    }
    
    deinit {
        print("🧹 GameViewModel deinit - cleaning up timers")
        gameTimer?.invalidate()
        gameTimer = nil
        hapticTimer?.invalidate()
        hapticTimer = nil
        stopHapticFeedback()
    }
}
