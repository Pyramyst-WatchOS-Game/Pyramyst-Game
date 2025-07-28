//
//  GameView.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 24/07/25.
//

import SwiftUI
import SpriteKit

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @EnvironmentObject var router : Router

        var body: some View {
            SpriteView(scene: viewModel.scene)
                .ignoresSafeArea()
                .focusable(true)
                .digitalCrownRotation(
                    $viewModel.rotation,
                    from: 0.0, through: 50.0, by: 1.0,
                    sensitivity: .medium,
                    isContinuous: true,
                    isHapticFeedbackEnabled: false 
                )
                .onChange(of: viewModel.rotation) { _, newValue in
                    viewModel.updateRotation(to: newValue)
                }
        }
}

#Preview {
    GameView()
}
