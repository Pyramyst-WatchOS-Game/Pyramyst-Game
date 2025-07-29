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
    @EnvironmentObject var router: Router

    var body: some View {
        ZStack {
            SpriteView(scene: gameOverVM.gameOverScene)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .sheet(isPresented: $gameOverVM.showGameOverModal) {
            GameOverModalSheet(
                onRetry: {
                    gameOverVM.restartGame()
                    gameOverVM.resetModal()
                    router.reset()
                },
                onQuit: {
                    gameOverVM.resetGame()
                    router.reset()
                }
            )
        }
    }
}


#Preview {
    GameOverView()
}
