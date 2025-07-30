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
    
    //    func launchScene(image: String, name: String) {
    //
    //        let screenBounds = WKInterfaceDevice.current().screenBounds
    //        let screenSize = CGSize(width: screenBounds.width, height: screenBounds.height)
    //
    //
    //        let scene = SuccessScene(size: screenSize, treasureImageName: image, treasureText: name)
    //        scene.scaleMode = .aspectFill
    //
    //        self.successScene = scene
    //    }
    
    func updateLevel(level: Int) {
        
    }
    
    func updateCollectibles(id: UUID, isCollected: Bool, date: Date) {
        manager.updateItem(id: id, isCollected: isCollected, date: date)
    }
    
    //MARK: if item by level
    func getItem(_ level: Int) -> ItemModel? {
        guard let item = manager.getItemByLevel(level) else {
            print(" No item found for level \(level)")
            return nil
        }
        
        updateCollectibles(id: item.id, isCollected: true, date: Date())
        //        launchScene(image: item.image, name: item.name)
        treasure = item.image
        name = item.name
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
