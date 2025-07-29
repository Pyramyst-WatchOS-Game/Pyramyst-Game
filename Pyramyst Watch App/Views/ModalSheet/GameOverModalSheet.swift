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
        VStack(spacing: 16) {
            Text("Game Over")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            HStack(spacing: 10) {
                Button(action: {
                    isRetryPressed = true
                    onRetry()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isRetryPressed = false
                    }
                }) {
                    ZStack {
                        Image(isRetryPressed ? "clickedBtn" : "buttonBg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 50)
                            .cornerRadius(8)
                        Text("Retry")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }.buttonStyle(.plain)

                Button(action: {
                    isQuitPressed = true
                    onQuit()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isQuitPressed = false
                    }
                }) {
                    ZStack {
                        Image(isQuitPressed ? "clickedBtn" : "buttonBg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 50)
                            .cornerRadius(8)
                        Text("Home")
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                    }
                }
                .buttonStyle(.plain)
               
            }.padding(.horizontal,10)
        }
        .padding()
    }
}

#Preview {
    GameOverModalSheet {
        print("Retry pressed")
    } onQuit: {
        print("Home pressed")
    }
}
