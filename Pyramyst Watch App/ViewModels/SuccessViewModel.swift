//
//  SuccessViewModel.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 28/07/25.
//

import Foundation

class SuccessViewModel : ObservableObject {
    var manager = UserDefaultManager()
    
    @Published var successScene: SuccessScene? = nil
    
    func launchScene(image: String, name: String) {
        let scene = SuccessScene(size: CGSize(width: 184, height: 224), treasureImageName: image, treasureText: name)
        scene.scaleMode = .resizeFill
        self.successScene = scene
    }

    func updateLevel(level: GameLevel) {
    
    }
    
    func updateCollectibles(id: UUID, isCollected: Bool, date: Date) {
        manager.updateItem(id: id, isCollected: isCollected, date: date)
    }
    
    //MARK: if item by level
    func getItem(_ level: Int) -> ItemModel? {
        guard let item = manager.getItemByLevel(level) else {
            print("❌ No item found for level \(level)")
            return nil
        }

        updateCollectibles(id: item.id, isCollected: true, date: Date())
        launchScene(image: item.image, name: item.name)
        return item
    }
    
    //MARK: if item by random
//    func getRandomItemFromManager() {
//        guard let item = manager.getRandomItem() else {
//            print("No Items Found from getRandomItemFromManager")
//            return
//        }
//        
//        if !item.isCollected {
//            updateCollectibles(id: item.id, isCollected: true, date: Date())
//        }
//        
//        launchScene(image: item.image, name: item.name)
//    }
}
