//
//  SuccessView.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 28/07/25.
//

import SwiftUI
import SpriteKit

struct SuccessView: View {
    @EnvironmentObject var successVM: SuccessViewModel
    @EnvironmentObject var router: MainFlowRouter
    
    @State private var showGucci = false
    @State private var petiOffsetY: CGFloat = 0
    @State private var petiFall = false
    @State private var showTextAndButtons = false
    @State private var hidePeti = false
    
    @State private var gucciScale: CGFloat = 1.0
    @State private var gucciOffsetY: CGFloat = -30
    
    @State private var viewSize: CGSize = .zero
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("endGameBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                
                VStack {
                    ZStack {
                        if !hidePeti {
                            Image("peti")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.8)
                                .offset(y: petiFall ? geometry.size.height : 0)
                                .opacity(petiFall ? 0 : 1)
                                .animation(.easeInOut(duration: 1), value: petiFall)
                        }
                        
                        if showGucci {
                            Image(successVM.treasure)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.4)
                                .scaleEffect(gucciScale)
                                .offset(y: gucciOffsetY)
                                .transition(.opacity.combined(with: .scale))
                                .animation(.easeInOut(duration: 1), value: gucciScale)
                                .animation(.easeInOut(duration: 1), value: gucciOffsetY)
                            
                        }
                        
                        Image("tutupPeti")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.8)
                            .offset(y: petiOffsetY)
                            .animation(.easeInOut(duration: 1), value: petiOffsetY)
                    }
                    .frame(maxHeight: geometry.size.height * 0.6)
                    
                    if showTextAndButtons {
                        VStack(spacing: geometry.size.height * 0.06) {
                            Text(successVM.name)
                                .font(.custom("LuckiestGuy-Regular", size: geometry.size.width * 0.1))
                                .foregroundColor(Color(uiColor: UIColor(named: "textColor") ?? .white))
                                .shadow(color: Color(uiColor: UIColor(named: "strokeColor") ?? .black), radius: 0, x:  0.7, y:  0.7)
                                .shadow(color: Color(uiColor: UIColor(named: "strokeColor") ?? .black), radius: 0, x: -0.7, y:  0.7)
                                .shadow(color: Color(uiColor: UIColor(named: "strokeColor") ?? .black), radius: 0, x:  0.7, y: -0.7)
                                .shadow(color: Color(uiColor: UIColor(named: "strokeColor") ?? .black), radius: 0, x: -0.7, y: -0.7)
                                .transition(.move(edge: .bottom).combined(with: .opacity))
                                .animation(.easeOut(duration: 1), value: showTextAndButtons)
                            
                            HStack(spacing: geometry.size.width * 0.06) {
                                Button(action: {
                                    router.navigateToRoot()
                                }) {
                                    Image("homeButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2)
                                }
                                .buttonStyle(NoTapAnimationStyle())
                                
                                Button(action: {
                                    let currentLevel = UserDefaultManager.shared.getCurrentLevel()
                                    print("GameView — Level: \(currentLevel)")
                                    router.navigateAndReplacePrevious(to: .gameView(UUID()))
                                }) {
                                    Image("nextButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.4, height: geometry.size.height * 0.2)
                                }
                                .buttonStyle(NoTapAnimationStyle())
                                
                            }
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.easeOut(duration: 1), value: showTextAndButtons)
                        }
                        .frame(maxHeight: geometry.size.height * 0.4)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .task {
                    await playAnimation(height: geometry.size.height)
                }
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("sukses view muncul")
        }
    }
    
    func playAnimation(height: CGFloat) async {
            await sleep(1)
            withAnimation {
                petiOffsetY = -height
            }
            
            await sleep(0.6)
            withAnimation {
                showGucci = true
            }
            
            await sleep(1.0)
            withAnimation {
                petiFall = true
            }
            
            await sleep(0.8)
            hidePeti = true
            withAnimation {
                showTextAndButtons = true
            }
            
            await sleep(0.2)
            withAnimation(.easeInOut(duration: 0.7)) {
                gucciScale = 1.5
                gucciOffsetY = 10
            }
        }
}

#Preview {
    SuccessView()
        .environmentObject(SuccessViewModel())
        .environmentObject(MainFlowRouter())
}
