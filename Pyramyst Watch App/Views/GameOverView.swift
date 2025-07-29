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
                .ignoresSafeArea()

            if gameOverVM.showGameOverModal {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                GameOverModalSheet(
                    onRetry: {
                        gameOverVM.resetModal()
                        router.reset()
                        router.navigateTo(to: .gameplay)
                    },
                    onQuit: {
                        gameOverVM.resetGame()
                        router.reset()
                    }
                )
                .transition(.scale)
                .zIndex(1)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    GameOverView()
}
