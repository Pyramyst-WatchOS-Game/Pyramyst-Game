//
//  SceneViewModel.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 29/07/25.
//

import Foundation

class SceneViewModel: ObservableObject {
    let id = UUID()
    @Published var isRetry = false

    init() {
        print("🌀 SceneViewModel created: \(id)")
    }
}
