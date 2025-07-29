//
//  UserModel.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 25/07/25.
//

import Foundation

enum GameLevel: Int, Codable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
    case thirteen = 13
    case fourteen = 14
    case fifteen = 15
    case sixteen = 16
    case seventeen = 17
    case eighteen = 18
    case nineteen = 19
    case twenty = 20
}

struct UserModel: Codable {
    var level: GameLevel
}
