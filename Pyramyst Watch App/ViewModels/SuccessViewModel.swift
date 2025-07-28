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
}
