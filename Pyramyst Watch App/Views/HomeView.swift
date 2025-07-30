////
////  HomeView.swift
////  Pyramyst Watch App
////
////  Created by Muhamad Gatot Supiadin on 27/07/25.
////
//
//import SwiftUI
//import SpriteKit
//
//struct HomeView: View {
//    @EnvironmentObject var router: Router
//    @StateObject private var viewModel = HomeViewModel()
//
//    var body: some View {
////        NavigationStack(path: $router.path) {
//            GeometryReader { geometry in
//                SpriteView(scene: viewModel.scene)
//                    .ignoresSafeArea()
//                    .contentShape(Rectangle()) // Pastikan seluruh area bisa di-tap
//                    .onTapGesture { location in
//                        viewModel.handleTap(at: location, in: geometry)
//                    }
//            }
//            .onAppear {
//                setupNavigation()
//            }
////            .navigationDestination(for: RouterEnum.self) { route in
////                switch route {
////                case .gameplay:
////                    GameView()
////                case .collectibles:
////                    CollectibleView()
////                case .home:
////                    HomeView()
////                }
////            }
////        }
//    }
//
//    private func setupNavigation() {
//        viewModel.onNavigateToGame = {
////            router.navigateTo(to: .gameplay)
//            print("Navigating to gameplay")
//
//        }
//
//        viewModel.onNavigateToCollectibles = {
////            router.navigateTo(to: .collectibles)
//            print("Navigating to collectibles")
//        }
//    }
//}
//
//#Preview {
//    HomeView()
//        .environmentObject(Router())
//}


//
//  HomeView.swift
//  Pyramyst Watch App
//
//  Created by Ali Ganteng? jelek njir on 27/07/25.
//

import SwiftUI
import WatchKit

struct HomeView: View {
    
    @StateObject private var router = MainFlowRouter()
    
    @Namespace private var namespace
    
    init() {
        print("HomeView initialized")
    }
    
    var body: some View {
        NavigationStack(path: $router.navPaths) {
            mainView
                .navigationDestination(for: MainFlow.self) { destination in
                    destination.destinationView
                        .navigationTitle(destination.title)
                        .toolbarRole(.automatic)
                }
        }
        .environmentObject(router)
    }
    
    private var mainView: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Image
                
                Image("desertFrame")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width + 7, height: geometry.size.height + 7)
                    .offset(y: -geometry.size.height * 0.018)
                    .clipped()
                
                VStack(spacing: 0) {
        
                    ZStack() {
                        Image("logoPyramyst")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: logoHeight(for: geometry))
                            .padding(.bottom, geometry.size.height * 0.11)
                        
                        Button(action: {
                            playButtonTapped()
                        }) {
                            Image("buttonPlay")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: playButtonHeight(for: geometry))
                                .padding(.top, geometry.size.height * 0.2)
                        }
                        .buttonStyle(.plain)
                    }
                    .offset(y: geometry.size.height * 0.2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: geometry.size.height * 0.6)
//                    .background(.red)
                    
                    HStack {
                        Button(action: {
                            collectionButtonTapped()
                        }) {
                            Image("collectionButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: buttonSize(for: geometry),
                                       height: buttonSize(for: geometry))
                                .padding(.top, geometry.size.height * 0.08)
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                    }
                    .padding(.horizontal, horizontalPadding(for: geometry))
                    .frame(height: geometry.size.height * 0.2)
                    .offset(y: geometry.size.height * 0.09)
                    
                    // Bottom spacer
                    Spacer()
                        .frame(height: geometry.size.height * 0.2)
                }
//                .padding(.top, geometry.size.height * 0.4)
            }
            .background(Color(uiColor: UIColor(named: "mainMenuColor") ?? .yellow))
        }
        .ignoresSafeArea(.all)
    }

    // Helper functions untuk responsive sizing
    private func buttonSize(for geometry: GeometryProxy) -> CGFloat {
        min(geometry.size.width * 0.18, 35) // Max 35, min 18% dari width
    }

    private func horizontalPadding(for geometry: GeometryProxy) -> CGFloat {
        geometry.size.width * 0.05 // 5% dari width
    }
    
    private func topPadding(for geometry: GeometryProxy) -> CGFloat {
        geometry.size.height * 0.21 // 5% dari height
    }

    private func centerSpacing(for geometry: GeometryProxy) -> CGFloat {
        min(geometry.size.height * 0.1, 20) // Max 20, min 10% dari height
    }

    private func logoHeight(for geometry: GeometryProxy) -> CGFloat {
        geometry.size.height * 0.7 // 25% dari height
    }

    private func playButtonHeight(for geometry: GeometryProxy) -> CGFloat {
        geometry.size.height * 0.2 // 20% dari height
    }
    
    private func playButtonTapped() {
        WKInterfaceDevice.current().play(.click)
        router.navigateTo(.storyView)
    }
    
    private func collectionButtonTapped() {
        
        WKInterfaceDevice.current().play(.click)
        router.navigateTo(.inventoryView)
    }
}

struct NoTapAnimationStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
