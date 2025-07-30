//
//  PyramystApp.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 24/07/25.
//

import SwiftUI

@main
struct Pyramyst_Watch_App: App {
    @StateObject var successVM = SuccessViewModel()
    @StateObject var sceneVM = SceneViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .environmentObject(successVM)
        .environmentObject(sceneVM)
    }
}
