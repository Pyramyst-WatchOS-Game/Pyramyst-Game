//
//  UserDefaultManager.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 25/07/25.
//

import Foundation

class UserDefaultManager {
    static let shared = UserDefaultManager()
    init() {}
    
    //MARK: Keys
    private let itemsKey = "collectedItemsKey"
    private let userLevelKey = "userLevelKey"
    
    //MARK: Items Collectible functions
    func loadItems() -> [ItemModel] {
        guard let data = UserDefaults.standard.data(forKey: itemsKey) else { return [] }
        do {
            return try JSONDecoder().decode([ItemModel].self, from: data)
        } catch {
            print("Failed to load items: \(error)")
            return []
        }
    }
    
    func saveItems(_ items: [ItemModel]) {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: itemsKey)
        } catch {
            print("Failed to save items: \(error)")
        }
    }
    
    func initItems() {
        let existingItems = loadItems()
        if !existingItems.isEmpty {
            return
        }
        let defaultItems: [ItemModel] = defaultCollectibleItems // init from constant items
        saveItems(defaultItems)
    }
    
    func updateItem(id: UUID, isCollected: Bool, date: Date = Date()) {
        var items = loadItems()
        if let idx = items.firstIndex(where: { $0.id == id }) {
            items[idx].isCollected = isCollected
            items[idx].collectedDate = isCollected ? date : nil
            saveItems(items)
        }
    }
    
    //MARK: User level functions
    func resetLevel() {
        UserDefaults.standard.set(GameLevel.one.rawValue, forKey: userLevelKey)
    }
    
    func updateLevel(_ level: GameLevel) -> Void {
        UserDefaults.standard.set(level.rawValue, forKey: userLevelKey)
    }
    
    func getCurrentLevel() -> GameLevel {
        let rawValue = UserDefaults.standard.integer(forKey: userLevelKey)
        return GameLevel(rawValue: rawValue) ?? .one
    }
}
