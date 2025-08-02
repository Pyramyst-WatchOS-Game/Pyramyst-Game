//
//  HomeViewModel.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 28/07/25.
//

import SpriteKit
import WatchKit
import SwiftUICore

final class HomeViewModel: ObservableObject {
    let scene: HomeScene
    
    var onNavigateToGame: (() -> Void)?
    var onNavigateToCollectibles: (() -> Void)?
    
    init() {
        let screenBounds = WKInterfaceDevice.current().screenBounds
        let screenSize = CGSize(width: screenBounds.width, height: screenBounds.height)
        
        let homeScene = HomeScene(size: screenSize)
        homeScene.scaleMode = .aspectFill
        self.scene = homeScene
        
        setupSceneCallbacks()
    }
    
    private func setupSceneCallbacks() {
        scene.onPlayTapped = { [weak self] in
            self?.onNavigateToGame?()
        }
        
        scene.onCollectiblesTapped = { [weak self] in
            self?.onNavigateToCollectibles?()
        }
    }
    
    func handleTap(at location: CGPoint, in geometry: GeometryProxy) {
        let sceneLocation = convertToSceneCoordinates(
            swiftUILocation: location,
            geometry: geometry,
            sceneSize: scene.size
        )
        
        scene.handleTap(at: sceneLocation)
    }
    
    private func convertToSceneCoordinates(
        swiftUILocation: CGPoint,
        geometry: GeometryProxy,
        sceneSize: CGSize
    ) -> CGPoint {
        let sceneX = (swiftUILocation.x / geometry.size.width) * sceneSize.width
        let sceneY = sceneSize.height - ((swiftUILocation.y / geometry.size.height) * sceneSize.height)
        
        return CGPoint(x: sceneX, y: sceneY)
    }
}
