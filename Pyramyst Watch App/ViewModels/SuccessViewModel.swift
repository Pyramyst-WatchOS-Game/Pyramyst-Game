//
//  SuccessViewModel.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 28/07/25.
//

import Foundation
import WatchKit

class SuccessViewModel : ObservableObject {
    var manager = UserDefaultManager()
    
    @Published var successScene: SuccessScene? = nil
    @Published var treasure: String = ""
    @Published var name: String = ""
    
    func updateLevel(level: Int) {
        
    }
    
    func updateCollectibles(id: UUID, isCollected: Bool, date: Date) {
        manager.updateItem(id: id, isCollected: isCollected, date: date)
    }
    
    func getItem(_ level: Int) -> ItemModel? {
        guard let item = manager.getItemByLevel(level) else {
            print(" No item found for level \(level)")
            return nil
        }
        
        updateCollectibles(id: item.id, isCollected: true, date: Date())
        treasure = item.image
        name = item.name
        return item
    }
    
}
