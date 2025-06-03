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
  
  private(set) var gameId: Int
  private(set) var namespace: Namespace.ID
  private(set) var isPresented: Binding<Bool>
  
  private(set) var gameDetail: GameDetail = GameDetail.emptyObject()
  private(set) var thumbNailId: String = ""
  private(set) var imageUrl: URL? = nil
  private(set) var aboutGame: String = ""
  
  private var isLoadedData: Bool = false
  
  //MARK: Init
  
  @MainActor
  init(gameId: Int, namespace: Namespace.ID, isPresented: Binding<Bool>, client: DetailClientProvider = DetailClient()) {
    self.gameId = gameId
    self.namespace = namespace
    self._isPresented = isPresented
    self.client = client
  }
  
  //MARK: Methods
  
  func didTapCloseView() {
    isPresented.wrappedValue = false
    imageUrl = nil
    thumbNailId = ""
  }
  
  
  @MainActor
  func fethGameDetail() async {
    do {
      let gameDetail = try await client.fetchDetail(by: gameId)
      self.gameDetail = gameDetail
      thumbNailId = "thumbnail_\(gameDetail.id)"
      imageUrl = URL(string: gameDetail.thumbnail)
      aboutGame = "About \(gameDetail.title)"
      debugPrint("Screenshoots", gameDetail.screenshots)
    } catch {
      debugPrint(error)
    }
  }
  
  //MARK: Private Methods
  
}
