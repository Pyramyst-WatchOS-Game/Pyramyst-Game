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
        ScrollView {
            LazyVStack(spacing: 4) {
                ForEach(viewModel.items) { item in
                    HStack(spacing: 12) {
                        Image(item.image)
                            .renderingMode(item.isCollected ? .original : .template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(item.isCollected ? .green : .black)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.isCollected ? item.name : "???")
                                .font(.system(size: 12, weight: .bold))

                            Text(item.isCollected ? "Collected" : "Not Collected")
                                .font(.system(size: 10))
                                .foregroundColor(.secondary)
                        }

                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .padding(.leading, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.orange.opacity(0.6)]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .shadow(color: .orange.opacity(0.4), radius: 6, x: 0, y: 4)
                    )
                    .padding(.horizontal, 8)
                }
            }
            .padding(.vertical, 12)
        }
    }
}
