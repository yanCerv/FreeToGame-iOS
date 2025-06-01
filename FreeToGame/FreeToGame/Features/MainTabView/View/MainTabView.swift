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
            Text("Games")
          }
        
        ListGenreView(viewModel: ListGenreViewModel())
          .tabItem {
            Image(systemName: "square.and.arrow.up.on.square")
            Text("Genres")
          }
      }
      .tint(.white)
      .preferredColorScheme(.dark)
      .toolbar {
        NavigationButton(imageName: "person.fill") {
          navigation.paths.append(.profile)
        }
      }
      .navigationTitle("Free To Game")
      .navigationBarTitleDisplayMode(.inline)
      .toolbarBackground(.visible, for: .navigationBar)
      .navigationDestination(for: NavigationPath.self) { path in
        switch path {
        case .profile:
          Text("profile view")
        case .description:
          Text("description view")
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
