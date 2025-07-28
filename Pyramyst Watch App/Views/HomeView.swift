//
//  HomeView.swift
//  Pyramyst
//
//  Created by Muhamad Gatot Supiadin on 27/07/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack( path: $router.path) {
            VStack {
                Button("Play game") {
                    router.navigateTo(to: .gameplay)
                }
                Button("Go to collection") {
                    router.navigateTo(to: .inventory)
                }
            }
            .navigationDestination(for: RouterEnum.self) { route in
                switch route {
                case .gameplay:
                    GameView()
                case .inventory:
                    InventoryView()
                case .home:
                    HomeView()
                case .gameOver:
                    GameOverView()
                case .success:
                    SuccessView()
                }
            }
        }
    }
}
