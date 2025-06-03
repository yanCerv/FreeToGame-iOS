//
//  GameDetailView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

struct GameDetailView: View {
  
  @State var viewModel: GameDetailViewModel
  
  var body: some View {
    ScrollView {
      VStack {
        NavigationButton(imageName: "xmark.circle.fill", action: {
          withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
            viewModel.didTapCloseView()
          }
        })
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 20)
        .padding(.top, 10)
        
        Text(viewModel.gameDetail.title)
          .font(.largeTitle).bold()
          .foregroundColor(.white)
          .opacity(0.8)
          .padding(.top, 10)
          .padding(.horizontal, 16)
        
        AsyncImage(url: viewModel.imageUrl) { phase in
          switch phase {
          case .success(let image):
            image
              .resizable()
              .scaledToFit()
          default:
            Color.red.opacity(0.2)
          }
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .matchedGeometryEffect(id: viewModel.thumbNailId, in: viewModel.namespace)
        
        Text(viewModel.aboutGame)
          .font(.title).fontWeight(.medium)
          .foregroundStyle(.secondary)
          .padding(.vertical, 10)
          .padding(.horizontal, 16)
        
        Text(viewModel.gameDetail.welcomeDescription)
          .font(.subheadline).fontWeight(.medium)
          .foregroundStyle(.secondary)
          .padding(.horizontal, 16)
        
        Text("Screenshoots")
          .font(.subheadline).bold()
          .foregroundStyle(.secondary)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, 16)
          .padding(.horizontal, 16)
        
        DetailScreenShootsView(gameDetails: viewModel.gameDetail)
          .padding(.horizontal, 16)

      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black.edgesIgnoringSafeArea(.all))
    .task {
      await viewModel.fethGameDetail()
    }
  }
}
