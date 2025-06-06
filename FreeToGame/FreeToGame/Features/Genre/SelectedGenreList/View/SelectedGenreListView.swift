//
//  SelectedGenreListView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import SwiftUI

struct SelectedGenreListView: View {
  
  @EnvironmentObject var navigation: NavigationManager
  
  @State var viewModel: SelectedGenreListViewModel
  @Namespace var namespace
  
  var body: some View {
    ContentView(loaderState: viewModel.loaderState) {
      ScrollView {
        LazyVGrid(columns: viewModel.columns, spacing: 6) {
          ForEach(viewModel.games, id: \.self) { game in
            GridGameCardView(game: game, namespace: namespace)
              .onTapGesture {
                withAnimation(.spring(response: 0.9, dampingFraction: 1.2)) {
                  viewModel.didtapOn(game)
                }
              }
          }
        }
        .padding(.horizontal, 16)
      }
      .task {
        await viewModel.didFetchGamesFromGenre()
      }
    }
    .navigationTitle(viewModel.genre)
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
    .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
      Button("OK") {
        viewModel.didTapAlertAction()
        navigation.back()
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        NavigationButton(imageName: "chevron.backward") {
          navigation.back()
        }
      }
    }
  }
}

#Preview {
  SelectedGenreListView(viewModel: SelectedGenreListViewModel(genre: "Action"))
    .environmentObject(NavigationManager())
}
