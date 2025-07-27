//
//  GameOverView.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 27/07/25.
//

import SwiftUI
import SpriteKit

struct GameOverView: View {
    @StateObject private var gameOverVM = GameOverViewModel()

    var body: some View {
        ZStack {
            SpriteView(scene: gameOverVM.gameOverScene)
        }
        .sheet(isPresented: $gameOverVM.showGameOverModal) {
            GameOverModalSheet(
                onRetry: {
                    gameOverVM.restartGame()
                    gameOverVM.resetModal()
                },
                onQuit: {
                    gameOverVM.resetGame()
                }
            )
        }
    }
}


#Preview {
    GameOverView()
}
