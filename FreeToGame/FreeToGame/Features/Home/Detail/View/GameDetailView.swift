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
    VStack {
        NavigationButton(imageName: "xmark.circle.fill", action: {
          withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
            viewModel.didTapCloseView()
          }
        })
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 20)
        .padding(.top, 10)

      ScrollView {
        VStack {
          CachedImage(url: viewModel.imageUrl) { phase in
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
          
          HStack {
            Button {
              viewModel.didTapShowRequirements()
            } label: {
              Text("SO Requirements")
            }
            .buttonStyle(DetailCorneredButtonStyle())
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)

            Button {
              viewModel.didTapShowRequirements()
            } label: {
              Text("Additional Information")
            }
            .buttonStyle(DetailCorneredButtonStyle())
            .frame(maxWidth: .infinity ,alignment: .trailing)
            .padding(.horizontal, 16)
          }
          
          DetailDescriptionView(aboutGame: viewModel.aboutGame,
                                welcomeDescription: viewModel.gameDetail.welcomeDescription)
    
          DetailScreenShootsView(gameDetails: viewModel.gameDetail)
            .padding(.horizontal, 16)
          
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black.edgesIgnoringSafeArea(.all))
    .sheet(isPresented: $viewModel.isShowRequirements) {
      DetailRequirementsView(requirements: viewModel.gameDetail.minimumSystemRequirements)
        .presentationDetents([.fraction(0.4)])
        .presentationDragIndicator(.visible)
    }
    .task {
      await viewModel.fethGameDetail()
    }
  }
}
