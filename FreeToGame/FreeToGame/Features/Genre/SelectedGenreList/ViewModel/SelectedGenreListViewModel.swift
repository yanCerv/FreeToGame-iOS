//
//  SelectedGenreListViewModel.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import SwiftUI

@Observable
final class SelectedGenreListViewModel {
  private(set) var genre: String
  private let client: ListGenreProvider
  
  private(set) var isLoadedData: Bool = false
  private(set) var loaderState: LoaderState = .finishLoading
  private(set) var games: [Game] = []
  private(set) var alertMessage: String = ""
  
  private(set) var columns = [GridItem(.fixed(160)), GridItem(.fixed(160))]
  
  var showAlert: Bool = false
  var isShowDetail: Bool = false
  var gameSelected: Game? = nil
  
  //MARK: Init
  
  @MainActor
  init(genre: String, client: ListGenreProvider = ListGenreClient()) {
    self.genre = genre
    self.client = client
  }
  
  //MARK: Methods
  
  func didTapAlertAction() {
    showAlert = false
    alertMessage = ""
  }
  
  func didtapOn(_ game: Game) {
    gameSelected = game
    isShowDetail = true
  }
  
  @MainActor
  func didFetchGamesFromGenre() async {
    guard !isLoadedData else { return }
    loaderState = .startLoading
    do {
      let dataGames = try await client.fetchList(genre)
      games = dataGames
    } catch {
      showAlert = true
      alertMessage = "No Games founded in this Genre"
    }
    isLoadedData = true
    loaderState = .finishLoading
  }
  
  //MARK: Private Methods
}
