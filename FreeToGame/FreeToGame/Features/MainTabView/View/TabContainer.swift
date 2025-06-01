//
//  TabContainer.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/12/24.
//

import SwiftUI

struct TabContainer: View {
  @EnvironmentObject var navigation: NavigationManager
  
  var body: some View {
    TabView {
      HomeView(viewModel: HomeViewModel())
        .tabItem {
          Image(systemName: "gamecontroller.fill")
          Text("All Games")
        }
    }
    .tint(.white)
    .preferredColorScheme(.dark)
  }
}
