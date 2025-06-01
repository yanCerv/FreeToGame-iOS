//
//  FreeToGameApp.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

import SwiftUI

@main
struct FreeToGameApp: App {
  
  var body: some Scene {
    WindowGroup {
      MainTabView()
        .environmentObject(NavigationManager())
    }
  }
}
