//
//  UserDefault.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 25/07/25.
//

import Foundation
import Combine

// Dummy init for 10 items collections
let defaultCollectibleItems: [ItemModel] = [
    ItemModel(name: "Sandtime Anubis", image: "sand", isCollected: true, level: 1),
    ItemModel(name: "Car of Anubis", image: "cat", isCollected: true, collectedDate: Calendar.current.date(byAdding: .day, value: -7, to: Date()), level: 2),
    ItemModel(name: "Desitiny of Egypt", image: "leaf", isCollected: true, collectedDate: Calendar.current.date(byAdding: .day, value: -3, to: Date()), level: 3),
    ItemModel(name: "Raa's gucci", image: "gucci", isCollected: true, collectedDate: Date(), level: 4),
    ItemModel(name: "Mummy's Firaus", image: "head", isCollected: false, level: 5),
    ItemModel(name: "Free of Ethernity", image: "fire", isCollected: false, level: 6),
    ItemModel(name: "item7", image: "item4", isCollected: false, level: 7),
    ItemModel(name: "item8", image: "item1", isCollected: false, level: 8),
    ItemModel(name: "item9", image: "item0", isCollected: false, level: 9),
    ItemModel(name: "item10", image: "item3", isCollected: false, level: 10)
]

