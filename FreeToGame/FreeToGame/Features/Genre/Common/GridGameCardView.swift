//
//  GridGameCardView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 04/06/25.
//

import SwiftUI

struct GridGameCardView: View {
  let game: Game
  var namespace: Namespace.ID

  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      CachedImage(url: URL(string: game.thumbnail)) { phase in
        switch phase {
        case .success(let image):
          image
            .resizable()
            .scaledToFill()
            .matchedGeometryEffect(id: "grid\(game.id)", in: namespace)
        default:
          Color.red.opacity(0.6)
        }
      }
      .frame(width: 160, height: 100)
      .clipped()

      Text(game.title)
        .font(.system(size: 10, weight: .regular))
        .foregroundColor(.secondary)
        .lineLimit(1)
        .padding(.horizontal, 6)
        .padding(.bottom, 6)
    }
    .background(Color.gray.opacity(0.5))
    .frame(width: 160)
    .cornerRadius(8)
  }
}
