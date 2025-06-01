//
//  GenreCardView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import SwiftUI

struct GenreCardView: View {
  
  var genre: String
  
  var body: some View {
    Button {
      //TODO
    } label: {
      VStack {
        HStack {
          Text(genre)
            .font(.system(size: 16, weight: .bold))
            .foregroundStyle(.white.opacity(0.7))
            .frame(maxWidth: .infinity, alignment: .leading)
          Image(systemName: "chevron.right")
            .foregroundStyle(.white.opacity(0.7))
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        
        Divider()
          .foregroundStyle(.white.opacity(0.7))
      }
    }
    .frame(height: 55)
    .padding(.horizontal, 10)
  }
}

#Preview {
  GenreCardView(genre: "MMORPG")
}
