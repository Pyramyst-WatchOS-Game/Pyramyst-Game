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
    @EnvironmentObject var router: MainFlowRouter

    var body: some View {
        ZStack {
            SpriteView(scene: gameOverVM.gameOverScene)
                .ignoresSafeArea()

            if gameOverVM.showGameOverModal {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                GameOverModalSheet(
                    onRetry: {
                        gameOverVM.resetModal()
                        router.navigateToRoot()
                        router.navigateTo(.gameView)
                    },
                    onQuit: {
                        gameOverVM.resetGame()
                        router.navigateToRoot()
                    }
                )
                .transition(.scale)
                .zIndex(1)
            }
        }
        .navigationBarHidden(true)
    }
}


#Preview {
    GameOverView()
}
