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
//  Created by Ali Ganteng? on 27/07/25.
//

import SwiftUI
import WatchKit

struct HomeView: View {

    @StateObject private var router = MainFlowRouter()
    @State private var isPlayButtonPressed = false
    @State private var isCollectionButtonPressed = false
    
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
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: {
                        collectionButtonTapped()
                    }) {
                        Image(isCollectionButtonPressed ? "collectionButtonClicked" : "collectionButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 35, height: 35)
                    }
                    .buttonStyle(NoTapAnimationStyle())
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 8)
                .padding(.top, 16)
                
                Spacer()
                
                 VStack(spacing: 50) {
                    Image("pyramystLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 70)
                    
                    Button(action: {
                        playButtonTapped()
                    }) {
                        Image(isPlayButtonPressed ? "playButtonClicked" : "playButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 55)
                    }
                    .buttonStyle(NoTapAnimationStyle())
                }
                
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
    
    private func playButtonTapped() {
        WKInterfaceDevice.current().play(.click)
        
        isPlayButtonPressed = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isPlayButtonPressed = false
            router.navigateTo(.storyView)
        }
        
    }
    
    private func collectionButtonTapped() {
       
        WKInterfaceDevice.current().play(.click)
        
        isCollectionButtonPressed = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isCollectionButtonPressed = false
            router.navigateTo(.inventoryView)
        }
        
    }
}

struct NoTapAnimationStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
