//
//  GameViewModel.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 24/07/25.
//

import SpriteKit
import Combine
import WatchKit

final class GameViewModel: ObservableObject {
    @Published var rotation: Double = 0.0
    
       let scene: SKScene

       private var lastTick = 0
       private let maxTicks = 50

       init() {
           let sz = CGSize(width: 184, height: 224)
           let lockScene = GameScene(size: sz)
           lockScene.scaleMode = .resizeFill
           self.scene = lockScene
       }

       func updateRotation(to newValue: Double) {
           
           print("Updating rotation to \(newValue)")
           
           if let label = scene.childNode(withName: "rotationLabel") as? SKLabelNode {
               label.text = "\(Int(newValue))"
           }
           
           let angle = (newValue / Double(maxTicks)) * 2 * .pi
           print("Setting dial rotation to \(angle) radians")
           
           scene.childNode(withName: "dial")?.zRotation = CGFloat(angle)

           let tick = Int(newValue) % maxTicks
           
           print(tick)
           if tick != lastTick {
               WKInterfaceDevice.current().play(.click)
               lastTick = tick
           }
       }
}
