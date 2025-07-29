//
//  InventoryViewModel.swift
//  Pyramyst
//
//  Created by Muhamad Gatot Supiadin on 27/07/25.
//

import Foundation
import SpriteKit
import Combine

class InventoryViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = []
    private let manager = UserDefaultManager.shared
    
    init() {
        manager.initItems()
        loadItem()
    }
    
    func loadItem () {
//        items = manager.loadItems().sorted{ ($0.collectedDate ?? .distantPast) > ($1.collectedDate ?? .distantPast) } // Sort by date
        items = manager.loadItems().sorted{ $0.level < $1.level } // sort by level
    }
    
    func toggleCollected(for item: ItemModel) {
        manager.updateItem(id: item.id, isCollected: !item.isCollected)
        print("Clicked and updated for \(item.id)")
        loadItem()
    }
}

