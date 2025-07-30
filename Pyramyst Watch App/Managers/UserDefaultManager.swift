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
    
    //MARK: - Items Collectible functions
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
    
    //MARK: - User level functions
    func resetLevel() {
        UserDefaults.standard.set(1, forKey: userLevelKey)
    }
    
    func updateLevel(_ level: Int) -> Void {
        UserDefaults.standard.set(level, forKey: userLevelKey)
    }
    
    func getCurrentLevel() -> Int {
        let level = UserDefaults.standard.integer(forKey: userLevelKey)
        return level > 0 ? level : 1
    }
    
    func goToNextLevel() {
        let current = getCurrentLevel()
        updateLevel(current + 1)
    }
    
    //MARK: if item by random
//    func getRandomItem() -> ItemModel? {
//        let items = loadItems()
//        
//        if let uncollectedItem = items.filter({ $0.isCollected == false }).randomElement() {
//            return uncollectedItem
//        }
//        
//        return items.randomElement()
//    }
    
    //MARK: - if item by level
    func getItemByLevel(_ level: Int) -> ItemModel? {
        let items = loadItems()
        return items.first { $0.level == level }
    }
}
