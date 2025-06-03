//
//  GameCardView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import SwiftUI

struct GameCardView: View {
  let game: Game
  var namespace: Namespace.ID

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      CachedImage(url: URL(string: game.thumbnail)) { phase in
        switch phase {
        case .success(let image):
          image
            .resizable()
            .scaledToFill()
            .matchedGeometryEffect(id: game.id, in: namespace)
        default:
          Color.red.opacity(0.6)
        }
      }
      .frame(width: 200, height: 150)
      
      Text(game.title)
        .font(.system(size: 15, weight: .bold))
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
  struct PreviewWrapper: View {
    @Namespace var namespace
    
    var body: some View {
      GameCardView(game: Game.previewGame(), namespace: namespace)
    }
  }
  return PreviewWrapper()
}
