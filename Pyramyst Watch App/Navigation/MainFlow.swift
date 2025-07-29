//
//  MainFlowRouter.swift
//  Pyramyst
//
//  Created by Ali An Nuur on 28/07/25.
//

import SwiftUI

enum MainFlow: NavigationDestination {
    
    case homeView
    case gameView
    case collectibleView
    
    var title: String {
        switch self {
        case .homeView:
            return "Home"
        case .gameView:
            return "Game"
        case .collectibleView:
            return "Collectibles"
        }
    }
    
    var destinationView: some View {
        switch self {
        case .homeView: HomeView()
        case .gameView: GameView()
        case .collectibleView: CollectibleView()
        }
    }
}

typealias MainFlowRouter = Router<MainFlow>
