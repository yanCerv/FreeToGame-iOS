//
//  MainTabView.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/12/24.
//

import SwiftUI

struct MainTabView: View {
  
  @EnvironmentObject var navigation: NavigationManager
  
  var body: some View {
    NavigationStack(path: $navigation.paths) {
      TabView {
        HomeView(viewModel: HomeViewModel())
          .tabItem {
            Image(systemName: "gamecontroller.fill")
            Text("Trending")
          }
        
        ListGenreView(viewModel: ListGenreViewModel())
          .tabItem {
            Image(systemName: "square.and.arrow.up.on.square")
            Text("Genres")
          }
      }
      .tint(.white)
      .preferredColorScheme(.dark)
      .navigationTitle("Free To Game")
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.visible, for: .navigationBar)
      .navigationDestination(for: NavigationPath.self) { path in
        switch path {
        case .search:
          Text("search view")
        case .description:
          Text("description view")
        case .listSelecte(let genre):
          SelectedGenreListView(viewModel: SelectedGenreListViewModel(genre: genre))
        }
      }
    }
    .foregroundStyle(.white)
    .preferredColorScheme(.dark)
  }
}

#Preview {
  MainTabView()
    .environmentObject(NavigationManager())
}
