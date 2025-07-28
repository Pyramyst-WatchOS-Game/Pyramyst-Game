//
//  SuccessView.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 28/07/25.
//

import SwiftUI
import SpriteKit

struct SuccessView: View {
    @StateObject private var successVM = SuccessViewModel()
    @EnvironmentObject var router: Router

    var body: some View {
        ZStack {
            SpriteView(scene: successVM.successScene)
        }
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}
#Preview {
    SuccessView()
}
