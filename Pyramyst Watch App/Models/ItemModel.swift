//
//  ItemModel.swift
//  Pyramyst
//
//  Created by Muhamad Gatot Supiadin on 27/07/25.
//
import Foundation

struct ItemModel: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var image: String
    var isCollected: Bool = false
    var collectedDate: Date?
}
