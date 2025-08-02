//
//  GamePlayModel.swift
//  Pyramyst
//
//  Created by Ali An Nuur on 28/07/25.
//

import Foundation

struct GamePlayModel {
    let level: Int
    let timeLimit: Double
    let firstCode: Int
    let secondCode: Int
    let thirdCode: Int
    var currentCircle: Int
    
    init(level: Int) {
        self.level = level
        let baseTime = 25.0
        let decrementPerLevel = 1.0
        let calculatedTime = baseTime - (Double(level - 1) * decrementPerLevel)
        self.timeLimit = max(5.0, calculatedTime)
        self.firstCode = Int.random(in: 0...49)
        self.secondCode = Int.random(in: 0...74)
        self.thirdCode = Int.random(in: 0...99)
        self.currentCircle = 1
    }
}
