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
    @EnvironmentObject var successVM: SuccessViewModel
    private var manager = UserDefaultManager.shared
    
    init() {
        print("🎯 Creating NEW GameViewModel instance: \(UUID())")
    
        let level = manager.getCurrentLevel()
        print("current level from gameview: \(level)")
        let gameModel: GamePlayModel = GamePlayModel(level: level > 0 ? level : 1)
        self._viewModel = StateObject(wrappedValue: GameViewModel(gameModel: gameModel))
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
                        router.navigateTo(.success)
                    }
                }
            }
            .onAppear {
                print("🎯 GameView appeared")
                viewModel.isGameOver = false
                viewModel.isGameCompleted = false
            }

    }
}

#Preview {
    GameView()
}


//struct GameViewWrapper: View {
//    @EnvironmentObject var router: MainFlowRouter
//    @EnvironmentObject var successVM: SuccessViewModel
//
//    @State private var showGameView = false
//    @State private var personOffset: CGFloat = -100
//    @State private var shouldHide = false
//
//    var body: some View {
//        ZStack {
//            if !showGameView {
//                Image("bgStory")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                VStack {
//                    Spacer()
//                    
//                    Image("orang")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 200)
//                        .offset(x: personOffset)
//                        .opacity(shouldHide ? 0 : 1)
//                        .animation(.easeOut(duration: 1), value: shouldHide)
//                        .animation(.easeInOut(duration: 1.5), value: personOffset)
//                        .padding(.top, 68)
//                    
//                    Spacer()
//                }
//            }
//
//            if showGameView {
//                GameView() 
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        .onAppear {
//            personOffset = -100
//            shouldHide = false
//            showGameView = false
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                personOffset = 100
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                    shouldHide = true
//                    
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                        showGameView = true
//                    }
//                }
//            }
//        }
//    }
//}
