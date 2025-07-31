//
//  StoryView.swift
//  Pyramyst
//
//  Created by Muhamad Gatot Supiadin on 29/07/25.
//

import SwiftUI

struct StoryView: View {
    @State private var moveRight = false
    @State private var showPerson = false
    @State private var showBackground = false
    @State private var hasAnimated = false
    @State private var showChest = false
    @State private var chestZoomIn = false
    @State private var hideChest = false
    @State private var showSecondBg = false
    @State private var chestOffsetX: CGFloat = 0
    @State private var secondBgOffsetX: CGFloat = 0
    
    @EnvironmentObject var router: MainFlowRouter
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if showBackground {
                    Image("bgStory")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
                if showPerson {
                    VStack {
                        Spacer()
                        Image("orang")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height)
                            .scaleEffect(moveRight ? 1 : 1.4)
                            .offset(x: moveRight ? geometry.size.width * 0.3 : 0)
                        //                            .offset(y: geometry.size.height * 0)
                            .animation(.easeInOut(duration: 1), value: moveRight)
                            .padding(.top, geometry.size.height * 0.1)
                        Spacer()
                    }
                    .transition(.opacity)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
                if showSecondBg {
                    Image("endGameBackground")
                        .resizable()
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .animation(.easeInOut(duration: 1.0), value: showSecondBg)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
                
                if showChest {
                    Image("petiFull")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.8)
                        .offset(
                            x: hideChest ? -geometry.size.width : 0,
                            y: -geometry.size.height * 0.13
                        )
                        .scaleEffect(chestZoomIn ? 7 : 1.0)
                        .opacity(hideChest ? 0 : 1)
                        .transition(.move(edge: .bottom))
                        .animation(.easeInOut(duration: 1.2), value: chestZoomIn)
                        .animation(.easeOut(duration: 1.2), value: showChest)
                        .animation(.easeOut(duration: 1.0), value: hideChest)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .navigationBarBackButtonHidden(true)
            .task {
                guard !hasAnimated else { return }
                hasAnimated = true
                await playStoryAnimation()
            }
        }
        .ignoresSafeArea(.all)
    }
    
    func playStoryAnimation() async {
        withAnimation(.easeInOut(duration: 0.1)) {
            showBackground = true
            showPerson = true
        }
        
        await sleep(1.0)
        moveRight = true
        
        await sleep(1.5)
        withAnimation(.easeInOut(duration: 0.8)) {
            showPerson = false
            showBackground = false
        }
        
        await sleep(0.1)
        withAnimation {
            showSecondBg = true
        }
        
        await sleep(0.1)
        withAnimation {
            showChest = true
        }
        
        await sleep(0.5)
        withAnimation {
            chestZoomIn = true
        }
        
        await sleep(1.5)
        withAnimation {
            showSecondBg = false
            hideChest = true
        }
        
        await sleep(0.3)
        router.navigate(to: .gameView(UUID()))
    }
    
}

func sleep(_ seconds: Double) async {
    let duration = UInt64(seconds * 1_000_000_000)
    try? await Task.sleep(nanoseconds: duration)
}

#Preview {
    StoryView()
        .environmentObject(MainFlowRouter())
}
