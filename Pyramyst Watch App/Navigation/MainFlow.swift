//
//  MainFlowRouter.swift
//  Pyramyst
//
//  Created by Ali An Nuur on 28/07/25.
//

import SwiftUI

enum MainFlow: NavigationDestination, Hashable {
    
    case homeView
    case gameView(UUID)
    case inventoryView
    case gameOver
    case success
    case storyView
    
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
            return "Success"
        case .storyView:
            return ""
        }
    }
    
    var destinationView: some View {
        switch self {
        case .homeView: HomeView()
        case .gameView(let id): GameView(gameID: id)
        case .inventoryView: InventoryView()
        case .gameOver: GameOverView()
        case .success: SuccessView()
        case .storyView: StoryView()
        }
    }
}

typealias MainFlowRouter = Router<MainFlow>
