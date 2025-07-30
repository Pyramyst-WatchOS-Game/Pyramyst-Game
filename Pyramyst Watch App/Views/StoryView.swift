//
//  StoryView.swift
//  Pyramyst
//
//  Created by Muhamad Gatot Supiadin on 29/07/25.
//

import SwiftUI

struct StoryView: View {
    @State private var moveRight = false
    @EnvironmentObject var router: MainFlowRouter
    @State private var hasNavigated = false
    
    @State private var appearZoom = false

    var body: some View {
        ZStack {
            Image("bgStory")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image("orang")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .scaleEffect(moveRight ? 0.8 : 1.2)
                    .offset(x: moveRight ? 120 : -80)
                    .animation(.easeInOut(duration: 2), value: moveRight)
                    .padding(.top, 68)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            appearZoom = true
            if hasNavigated { return }
            hasNavigated = true
            moveRight = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                router.navigate(to: .gameView)
            }
        }
    }
}


