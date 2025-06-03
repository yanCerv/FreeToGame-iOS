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
        LazyVStack {
          ForEach(viewModel.games, id: \.self) { game in
            GameCardView(game: game, namespace: namespace)
          }
        }
      }
      .task {
        await viewModel.didFetchGamesFromGenre()
      }
    }
    .navigationTitle(viewModel.genre)
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
