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
    ItemModel(name: "item1", image: "item2", isCollected: false),
    ItemModel(name: "item2", image: "item4", isCollected: true, collectedDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())),
    ItemModel(name: "item3", image: "item1", isCollected: true, collectedDate: Calendar.current.date(byAdding: .day, value: -3, to: Date())),
    ItemModel(name: "item4", image: "item0", isCollected: true, collectedDate: Date()),
    ItemModel(name: "item5", image: "item3", isCollected: false),
    ItemModel(name: "item6", image: "item2", isCollected: false),
    ItemModel(name: "item7", image: "item4", isCollected: false),
    ItemModel(name: "item8", image: "item1", isCollected: false),
    ItemModel(name: "item9", image: "item0", isCollected: true, collectedDate: Calendar.current.date(byAdding: .day, value: -14, to: Date())),
    ItemModel(name: "item10", image: "item3", isCollected: false)
]

