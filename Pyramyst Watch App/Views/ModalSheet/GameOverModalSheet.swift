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

    var body: some View {
        VStack(spacing: 16) {
            Text("Game Over")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            HStack(spacing: 20) {
                Button(action: onRetry) {
                    Text("Retry")
                        .frame(minWidth: 60)
                }
                .buttonStyle(.borderedProminent)

                Button(action: onQuit) {
                    Text("Back Home")
                        .frame(minWidth: 60)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
}

