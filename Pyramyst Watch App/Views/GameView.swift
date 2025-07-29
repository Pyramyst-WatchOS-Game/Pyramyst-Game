//
//  GameView.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 24/07/25.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject private var viewModel: GameViewModel
    @EnvironmentObject var router: MainFlowRouter
    
    init(gameModel: GamePlayModel = GamePlayModel(level: 1)) {
        self._viewModel = StateObject(wrappedValue: GameViewModel(gameModel: gameModel))
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
                    // Navigate to game over scene
                    router.navigateBack() // For now, go back to home
                }
            }
            .onChange(of: viewModel.isGameCompleted) { _, isCompleted in
                if isCompleted {
                    // Navigate to success scene or next level
                    router.navigateBack() // For now, go back to home
                }
            }
    }
}
#Preview {
    GameView()
}
