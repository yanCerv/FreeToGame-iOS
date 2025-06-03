//
//  HomeView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/12/24.
//

import SwiftUI

struct HomeView: View {
  
  @Bindable var viewModel: HomeViewModel
  @Namespace private var namespace
  
  var body: some View {
    ContentView(loaderState: viewModel.loaderState) {
      ScrollView {
        LazyVStack(alignment: .leading) {
          ForEach(viewModel.categoryGames, id: \.title) { category in
            Text(category.title)
              .font(.system(size: 26, weight: .bold))
              .foregroundColor(.white.opacity(0.8))
              .padding(10)
            
            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack(spacing: 12) {
                ForEach(category.games, id: \.self) { game in
                  GameCardView(game: game, namespace: namespace)
                    .onTapGesture {
                      withAnimation(.spring(response: 0.9, dampingFraction: 1.2)) {
                        viewModel.didtapOn(game)
                      }
                    }
                }
              }
              .padding(.horizontal)
            }
          }
        }
        .blur(radius: viewModel.isShowDetail ? 5 : 0)
      }
      .refreshable {
        await viewModel.fetchGames()
      }
      .overlay {
        if let gameSelected = viewModel.gameSelected,
           viewModel.isShowDetail {
          GameDetailView(viewModel: GameDetailViewModel(gameId: gameSelected.id,
                                                        namespace: namespace,
                                                        isPresented: $viewModel.isShowDetail))
          .zIndex(1)
          .toolbar(.hidden, for: .navigationBar)
        }
      }
      .task {
        await viewModel.fetchGames()
      }
    }
  }
}

#Preview {
  NavigationStack {
    HomeView(viewModel: HomeViewModel())
  }.preferredColorScheme(.dark)
}
