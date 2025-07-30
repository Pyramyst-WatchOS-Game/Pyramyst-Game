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
    @EnvironmentObject var sceneVM: SceneViewModel
    @EnvironmentObject var router: MainFlowRouter
    
    init() {
        print("GameOverView initialized")
    }

    var body: some View {
        ZStack {
            SpriteView(scene: gameOverVM.gameOverScene)
                .ignoresSafeArea()

            if gameOverVM.showGameOverModal {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                GameOverModalSheet(
                    onRetry: {
                        print("ini retry: \(sceneVM.isRetry)")
                        gameOverVM.resetModal()
                        router.navigateToRoot()
                        router.navigateAndReplacePrevious(to : .gameView(UUID()))
                    },
                    onQuit: {
                        sceneVM.isRetry = false
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
