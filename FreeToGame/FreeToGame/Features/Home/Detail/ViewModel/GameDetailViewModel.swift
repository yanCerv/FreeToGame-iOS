//
//  GameDetailViewModel.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import SwiftUI

@Observable
final class GameDetailViewModel {
  
  private let client: DetailClientProvider
  
  private(set) var game: Game
  private(set) var namespace: Namespace.ID
  private(set) var isPresented: Binding<Bool>
  
  private(set) var gameDetail: GameDetail = GameDetail.emptyObject()
  private(set) var imageUrl: URL? = nil
  private(set) var aboutGame: String = ""
  
  var isShowRequirements: Bool = false
  var isShowAditionalInfo: Bool = false
  var isLoadedData: Bool = false
  
  //MARK: Init
  
  @MainActor
  init(game: Game, namespace: Namespace.ID, isPresented: Binding<Bool>, client: DetailClientProvider = DetailClient()) {
    self.game = game
    self.namespace = namespace
    self._isPresented = isPresented
    self.client = client
    imageUrl = URL(string: game.thumbnail)
  }
  
  //MARK: Methods
  
  func didTapCloseView() {
    isPresented.wrappedValue = false
    imageUrl = nil
  }
  
  func didTapShowRequirements() {
    isShowRequirements = true
  }
  
  func didTapShowAditionalInfo() {
    isShowAditionalInfo = true
  }
  
  @MainActor
  func fethGameDetail() async {
    isLoadedData = false
    do {
      let gameDetail = try await client.fetchDetail(by: game.id)
      self.gameDetail = gameDetail
      aboutGame = "About \(gameDetail.title)"
      debugPrint("Screenshoots", gameDetail.screenshots)
    } catch {
      debugPrint(error)
    }
  }
  
  //MARK: Private Methods
  
}
