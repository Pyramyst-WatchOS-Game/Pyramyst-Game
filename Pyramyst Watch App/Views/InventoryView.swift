//
//  CollectibleView.swift
//  Pyramyst
//
//  Created by Muhamad Gatot Supiadin on 27/07/25.
//

import SwiftUI
import SpriteKit

struct InventoryView: View {
    @StateObject private var viewModel = InventoryViewModel()
    
    var body: some View {
        List(viewModel.items) { item in
            HStack(spacing: 10) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(item.isCollected ? .green : .gray)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.isCollected ? item.name : "???")
                        .font(.system(size: 14, weight: .bold))

                    Text(item.isCollected ? "Collected" : "Not Collected")
                        .font(.system(size: 10))
                        .foregroundColor(item.isCollected ? .green : .secondary)
                }
                Spacer()
            }
            .padding(.vertical, 4)
        }
        .listStyle(.carousel)
    }
}
