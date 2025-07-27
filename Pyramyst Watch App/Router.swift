//
//  Routes.swift
//  Pyramyst
//
//  Created by Muhamad Gatot Supiadin on 27/07/25.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigateTo(to route: RouterEnum) {
        path.append(route)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func reset() {
        path = NavigationPath()
    }
}
