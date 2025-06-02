//
//  HomeView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/12/24.
//

import SwiftUI

struct HomeView: View {
  
  @State var viewModel: HomeViewModel
  
  @Namespace private var namespace
  @State var isShowDetail: Bool = false
  @State var gameSelected: Game? = nil
  
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
                  GameCardView(game: game)
                    .onTapGesture {
                      withAnimation(.spring(response: 0.8, dampingFraction: 1.1)) {
                        gameSelected = game
                        isShowDetail = true
                      }
                    }
                }
              }
              .padding(.horizontal)
            }
          }
        }
        .blur(radius: isShowDetail ? 5 : 0)
      }
      .overlay {
        if let gameSelected = gameSelected,
           isShowDetail {
          GameDetailView(viewModel: GameDetailViewModel(game: gameSelected,
                                                        namespace: namespace,
                                                        isPresented: $isShowDetail))
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
