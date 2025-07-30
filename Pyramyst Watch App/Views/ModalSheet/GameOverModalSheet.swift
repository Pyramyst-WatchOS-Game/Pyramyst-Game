//
//  GameOverModalSheet.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 27/07/25.
//

import SwiftUI

struct GameOverModalSheet: View {
    let onRetry: () -> Void
    let onQuit: () -> Void

    @State private var isRetryPressed = false
    @State private var isQuitPressed = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("endGameBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea()

                VStack(spacing: geometry.size.height * 0.04) {
                    Image("gameOverText")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.6)

                    HStack(spacing: geometry.size.width * 0.05) {
                        
                        // Retry Button
                        Button(action: {
                            isRetryPressed = true
                            onRetry()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isRetryPressed = false
                            }
                        }) {
                            Image("retryButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2)
                        }
                        .buttonStyle(.plain)

                        // Quit Button
                        Button(action: {
                            isQuitPressed = true
                            onQuit()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isQuitPressed = false
                            }
                        }) {
                            Image("homeButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GameOverModalSheet {
        print("Retry pressed")
    } onQuit: {
        print("Home pressed")
    }
}
