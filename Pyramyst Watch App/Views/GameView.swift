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
    
    init(gameID: UUID) {
        print("🎯 Creating NEW GameViewModel instance: \(UUID())")
    
        let level = manager.getCurrentLevel()
        print("current level from gameview: \(level)")
        let gameModel: GamePlayModel = GamePlayModel(level: level > 0 ? level : 1)
        _viewModel = StateObject(wrappedValue: GameViewModel(gameModel: gameModel))
                self.gameID = gameID
                UserDefaultManager.shared.initItems()
    }
    
    var body: some View {
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
                        successVM.getItem(manager.getCurrentLevel() - 1)
                        router.navigateAndReplacePrevious(to: .success)
                    }
                }
            }

    }
}

//#Preview {
//    GameView()
//}
