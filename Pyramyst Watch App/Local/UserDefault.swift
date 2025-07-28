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
    ItemModel(name: "Sandtime Anubis", image: "sand", isCollected: true),
    ItemModel(name: "Car of Anubis", image: "cat", isCollected: true, collectedDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())),
    ItemModel(name: "Desitiny of Egypt", image: "leaf", isCollected: true, collectedDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())),
    ItemModel(name: "Raa's gucci", image: "gucci", isCollected: true, collectedDate: Date()),
    ItemModel(name: "Mummy's Firaus", image: "head", isCollected: false),
    ItemModel(name: "Free of Ethernity", image: "fire", isCollected: false),
    ItemModel(name: "item7", image: "item4", isCollected: false),
    ItemModel(name: "item8", image: "item1", isCollected: false),
    ItemModel(name: "item9", image: "item0", isCollected: false),
    ItemModel(name: "item10", image: "item3", isCollected: false)
]

