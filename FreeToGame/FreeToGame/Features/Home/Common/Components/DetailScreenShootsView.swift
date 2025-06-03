//
//  DetailScreenShootsView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct DetailScreenShootsView: View {
  
  var gameDetails: GameDetail = GameDetail.emptyObject()
  
  var body: some View {
    VStack {
      Text("Screenshoots")
        .font(.subheadline).bold()
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16)
        .padding(.horizontal, 16)
      
      ScrollView(.horizontal) {
        LazyHStack {
          ForEach(gameDetails.screenshots, id: \.self) { screenshot in
            AsyncImage(url: URL(string: screenshot.image)) { phase in
              switch phase {
              case .success(let image):
                image
                  .resizable()
                  .renderingMode(.original)
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 250, height: 200)
                  .clipped()
              default:
                Color.red.opacity(0.2)
              }
            }
          }
        }
      }
    }
  }
}

#Preview {
  DetailScreenShootsView()
}
