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
    case inventoryView
    case gameOver
    case success
    
    var title: String {
        switch self {
        case .homeView:
            return "Home"
        case .gameView:
            return "Game"
        case .inventoryView:
            return ""
        case .gameOver:
            return "Game Over"
        case .success:
            return ""
        }
    }
    
    var destinationView: some View {
        switch self {
        case .homeView: HomeView()
        case .gameView: GameView()
        case .inventoryView: InventoryView()
        case .gameOver: GameOverView()
        case .success: SuccessView()
        }
    }
}

typealias MainFlowRouter = Router<MainFlow>
