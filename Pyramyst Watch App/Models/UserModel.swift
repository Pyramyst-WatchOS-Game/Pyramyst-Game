//
//  UserModel.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 25/07/25.
//

import Foundation
// gatot
// alie

enum GameLevel: Int, Codable {
    case one = 1
    case two = 2
    case three = 3
}

struct UserModel: Codable {
    var level: GameLevel
}
