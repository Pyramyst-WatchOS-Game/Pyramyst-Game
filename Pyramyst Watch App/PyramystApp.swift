//
//  PyramystApp.swift
//  Pyramyst Watch App
//
//  Created by Ali An Nuur on 24/07/25.
//

import SwiftUI

@main
struct Pyramyst_Watch_App: App {
    @StateObject private var router = Router()
    @StateObject var successVM = SuccessViewModel()
    
    var body: some Scene {
           WindowGroup {
               HomeView()
           }
           .environmentObject(router)
           .environmentObject(successVM)
       }
}
