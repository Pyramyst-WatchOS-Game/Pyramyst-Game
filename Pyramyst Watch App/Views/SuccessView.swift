//
//  SuccessView.swift
//  Pyramyst Watch App
//
//  Created by Naela Fauzul Muna on 28/07/25.
//

import SwiftUI
import SpriteKit

struct SuccessView: View {
    @EnvironmentObject var successVM: SuccessViewModel
    @EnvironmentObject var router: MainFlowRouter
    
    var body: some View {
        ZStack {
            if let scene = successVM.successScene {
                SpriteView(scene: scene)
            } else {
               ProgressView()
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea()
        .onAppear {
            if let scene = successVM.successScene {
                print("Scene-nya ada nich: \(scene)")
            } else {
                print("Loh scene nil cok")
            }
        }
        

    }
}
#Preview {
    SuccessView()
}
