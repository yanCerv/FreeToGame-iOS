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
    ContentView(loaderState: viewModel.loaderState) {
      VStack {
        Text("ListGenreView")
        
      }
      .task {
        await viewModel.fetchGames()
      }
    }
  }
}
