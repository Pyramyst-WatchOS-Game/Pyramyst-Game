//
//  SuccessViewModel.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 28/07/25.
//

import Foundation

class SuccessViewModel : ObservableObject {
    var manager = UserDefaultManager()
    
    let successScene: SuccessScene
    
    init() {
        let size = CGSize(width: 184, height: 224)
        let scene = SuccessScene(size: size, treasureImageName: "treasure", treasureText: "Guci Firaun")
        scene.scaleMode = .resizeFill
        
        self.successScene = scene
    }
    
    func updateLevel(level: GameLevel) {
    
    }
    
    func updateCollectibles(id: UUID, isCollected: Bool, date: Date) {
        manager.updateItem(id: id, isCollected: isCollected, date: date)
    }
}
