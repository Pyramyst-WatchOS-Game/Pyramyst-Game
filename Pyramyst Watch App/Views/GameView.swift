//
//  GameView.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 24/07/25.
//
import SwiftUI
import SpriteKit

struct GameView: View {
    let gameID: UUID
    @StateObject private var viewModel: GameViewModel
    @EnvironmentObject var router: MainFlowRouter
    @EnvironmentObject var successVM: SuccessViewModel
    private var manager = UserDefaultManager.shared
    
    @State private var tutorialStep: Int = 0
    @State private var hasShownTutorial: Bool = false
    
    init(gameID: UUID) {
        let level = manager.getCurrentLevel()
        let gameModel: GamePlayModel = GamePlayModel(level: level > 0 ? level : 1)
        _viewModel = StateObject(wrappedValue: GameViewModel(gameModel: gameModel))
        self.gameID = gameID
        UserDefaultManager.shared.initItems()
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: viewModel.scene)
                .ignoresSafeArea()
                .focusable(true)
                .navigationBarHidden(true)
                .digitalCrownRotation(
                    $viewModel.rotation,
                    from: 0.0,
                    through: Double(viewModel.gameModel.currentCircle == 1 ? 50 : viewModel.gameModel.currentCircle == 2 ? 75 : 100),
                    by: 1.0,
                    sensitivity: .medium,
                    isContinuous: true,
                    isHapticFeedbackEnabled: false
                )
                .onChange(of: viewModel.rotation) { _, newValue in
                    viewModel.updateRotation(to: newValue)
                    if tutorialStep == 0 {
                        tutorialStep = 1
                    }
                    if tutorialStep == 1 {
                        let currentPosition = Int(newValue) % (viewModel.gameModel.currentCircle == 1 ? 50 : viewModel.gameModel.currentCircle == 2 ? 75 : 100)
                        let isCorrect = currentPosition == (viewModel.gameModel.currentCircle == 1 ? viewModel.gameModel.firstCode : viewModel.gameModel.currentCircle == 2 ? viewModel.gameModel.secondCode : viewModel.gameModel.thirdCode)
                        if isCorrect {
                            tutorialStep = 2
                        }
                    }
                    if tutorialStep == 2 {
                        let currentPosition = Int(newValue) % (viewModel.gameModel.currentCircle == 1 ? 50 : viewModel.gameModel.currentCircle == 2 ? 75 : 100)
                        let isCorrect = currentPosition == (viewModel.gameModel.currentCircle == 1 ? viewModel.gameModel.firstCode : viewModel.gameModel.currentCircle == 2 ? viewModel.gameModel.secondCode : viewModel.gameModel.thirdCode)
                        if !isCorrect {
                            tutorialStep = 1
                        }
                    }
                }
                .onTapGesture {
                    viewModel.submitCode()
                }
                .onChange(of: viewModel.isGameOver) { _, isGameOver in
                    if isGameOver {
                        router.navigateAndReplacePrevious(to: .gameOver)
                        viewModel.isGameOver = false
                    }
                }
                .onChange(of: viewModel.isGameCompleted) { _, isCompleted in
                    if isCompleted {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            let currLevel = manager.getCurrentLevel() - 1
                            if currLevel > 20 {
                                if let randomItem = manager.getRandomItemIfAllCollected() {
                                    successVM.getRandomItem(randomItem)
                                }
                            } else {
                                _ = successVM.getItem(manager.getCurrentLevel() - 1)
                            }
                            router.navigateAndReplacePrevious(to: .success)
                        }
                    }
                }
            
            if !hasShownTutorial && tutorialStep < 3 {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    if tutorialStep == 0 {
                        Text("How to Play")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                        Text("• Rotate the crown to move the dials.\n• Find the correct code and tap the screen to unlock the dial.\n• Timer will start when you complete the first dial.\n• Complete all dials to win!.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.horizontal, 0)
                    } else if tutorialStep == 1 {
                        Text("Find the Correct Code")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                        Text("Keep rotating the crown until you see the glowing correct sign.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                    } else if tutorialStep == 2 {
                        Text("Tap the Screen to Unlock")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .bold()
                            .foregroundColor(.white)
                        Text("Tap anywhere on the screen when the correct sign appears to unlock the dial.")
                            .font(.footnote)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            }
        }
        .onAppear {
            hasShownTutorial = UserDefaults.standard.bool(forKey: "hasShownGameTooltip")
            if !hasShownTutorial {
                tutorialStep = 0
            }
        }
        .onTapGesture {
            if tutorialStep == 2 {
                let currentPosition = Int(viewModel.rotation) % (viewModel.gameModel.currentCircle == 1 ? 50 : viewModel.gameModel.currentCircle == 2 ? 75 : 100)
                let isCorrect = currentPosition == (viewModel.gameModel.currentCircle == 1 ? viewModel.gameModel.firstCode : viewModel.gameModel.currentCircle == 2 ? viewModel.gameModel.secondCode : viewModel.gameModel.thirdCode)
                
                if isCorrect {
                    tutorialStep = 3
                    
                    UserDefaults.standard.set(true, forKey: "hasShownGameTooltip")
                    
                    viewModel.submitCode()
                
                }
            }
        }
    }
}
