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
    ItemModel(name: "Sandtime Anubis", image: "sand", isCollected: false, level: 1),
    ItemModel(name: "Cat of Anubis", image: "cat", isCollected: false, collectedDate: Calendar.current.date(byAdding: .day, value: -7, to: Date()), level: 2),
    ItemModel(name: "Desitiny of Egypt", image: "leaf", isCollected: false, collectedDate: Calendar.current.date(byAdding: .day, value: -3, to: Date()), level: 3),
    ItemModel(name: "Raa's gucci", image: "gucci", isCollected: false, collectedDate: Date(), level: 4),
    ItemModel(name: "Mummy's Firaus", image: "head", isCollected: false, level: 5),
    ItemModel(name: "Free of Ethernity", image: "fire", isCollected: false, level: 6),
    ItemModel(name: "Golden beetle", image: "bug", isCollected: false, level: 7),
    ItemModel(name: "Watch of Anubis", image: "compass", isCollected: false, level: 8),
    ItemModel(name: "Graveyard", image: "stone", isCollected: false, level: 9),
    ItemModel(name: "Miniature pyramid", image: "pyramid", isCollected: false, level: 10),
    ItemModel(name: "Egyptian map", image: "map", isCollected: false, level: 11),
    ItemModel(name: "Ankh necklace", image: "neckless", isCollected: false, level: 12),
    ItemModel(name: "Papyrus note", image: "paper", isCollected: false, level: 13),
    ItemModel(name: "Key of Sphinix", image: "key", isCollected: false, level: 14),
    ItemModel(name: "Ceremonial Cup", image: "mug", isCollected: false, level: 15),
    ItemModel(name: "Gold Ring", image: "ring", isCollected: false, level: 16),
    ItemModel(name: "Cobra Idol", image: "cobra", isCollected: false, level: 17),
    ItemModel(name: "Tomb Lock", image: "lock", isCollected: false, level: 18),
    ItemModel(name: "Ra's Sun Mirror", image: "mirror", isCollected: false, level: 19),
    ItemModel(name: "Obsidian Dagger", image: "dagger", isCollected: false, level: 20)
]

