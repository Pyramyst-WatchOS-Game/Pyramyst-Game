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
    
    init (){
        print("InventoryView initialized")
    }
    
    deinit {
        print("InventoryView deinitialized")
    }

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("Treasure Collected")
                        .font(.system(size: 12, weight: .bold))
                    Spacer()
                    Text("\(viewModel.items.filter(\.isCollected).count)/\(viewModel.items.count)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.green)
                }
                .padding(.horizontal)
                LazyVStack(spacing: 4) {
                    ForEach(viewModel.items) { item in
                        HStack(spacing: 8) {
                            Image(item.image)
                                .renderingMode(item.isCollected ? .original : .template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(item.isCollected ? .green : .black)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.isCollected ? item.name : "???")
                                    .font(.system(size: 12, weight: .bold))

                                Text(item.isCollected ? "Level \(item.level)" : "???")
                                    .font(.system(size: 8, weight: .bold))
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
}
