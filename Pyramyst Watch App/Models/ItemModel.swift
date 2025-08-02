//
//  ItemModel.swift
//  Pyramyst
//
//  Created by Muhamad Gatot Supiadin on 27/07/25.
//
import Foundation

struct ItemModel: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    let name: String
    let image: String
    var isCollected: Bool = false
    var collectedDate: Date?
    let level: Int
}
