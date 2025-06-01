//
//  NavigationManager.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/12/24.
//

import SwiftUI

enum NavigationPath: Hashable {
  case search
  case description
  case listSelecte(genre: String)
}


final class NavigationManager: ObservableObject {
  
  @Published var paths: [NavigationPath]
  
  // MARK: Init
  
  init(paths: [NavigationPath] = []) {
    self.paths = paths
  }
  
  //MARK: Methods
  
  func add(_ path: NavigationPath) {
    paths.append(path)
  }
  
  func back() {
    paths.removeLast()
  }
  
  func backToHome() {
    paths.removeAll()
  }
}
