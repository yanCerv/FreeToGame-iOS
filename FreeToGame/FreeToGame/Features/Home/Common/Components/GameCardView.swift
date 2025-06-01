//
//  GameCardView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import SwiftUI

struct GameCardView: View {
  let game: Game

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      AsyncImage(url: URL(string: game.thumbnail)) { phase in
        switch phase {
        case .empty:
          Color.gray.opacity(0.2)
        case .success(let image):
          image
            .resizable()
            .scaledToFill()
        case .failure:
          Color.red.opacity(0.2)
        @unknown default:
          Color.gray.opacity(0.2)
        }
      }
      .frame(width: 200, height: 140)
      .clipped()
      
      Text(game.title)
        .font(.system(size: 16, weight: .bold))
        .foregroundColor(.secondary)
        .lineLimit(2)
        .padding(8)
    }
    .background(Color.gray.opacity(0.5))
    .frame(width: 200)
    .cornerRadius(8)

  }
}

#Preview {
  GameCardView(game: Game.previewGame())
}
