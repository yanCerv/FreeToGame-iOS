//
//  GameDetailViewModel.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

@Observable
final class GameDetailViewModel {
  
  private(set) var game: Game
  private(set) var namespace: Namespace.ID
  private(set) var isPresented: Binding<Bool>
  private(set) var thumbNailId: String = ""
  private(set) var imageUrl : URL? = nil
  
  init(game: Game, namespace: Namespace.ID, isPresented: Binding<Bool>) {
    self.game = game
    self.namespace = namespace
    self._isPresented = isPresented
    thumbNailId = "thumbnail_\(game.id)"
    imageUrl = URL(string: game.thumbnail)
  }
  
  func didTapCloseView() {
    isPresented.wrappedValue = false
  }
}
