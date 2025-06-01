//
//  ListGenreView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import SwiftUI

struct ListGenreView: View {
  
  @State var viewModel: ListGenreViewModel
  
  var body: some View {
    ScrollView {
      LazyVStack {
        ForEach(viewModel.genres, id: \.self) { genre in
          GenreCardView(genre: genre)
        }
      }
    }
    .task {
      await viewModel.fetchGames()
    }
  }
}

#Preview {
  ListGenreView(viewModel: ListGenreViewModel(HomeClient(.mock)))
}
