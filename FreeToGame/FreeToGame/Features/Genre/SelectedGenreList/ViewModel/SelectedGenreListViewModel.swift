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
  
  //MARK: Init
  
  @MainActor
  init(genre: String, client: ListGenreProvider = ListGenreClient()) {
    self.genre = genre
    self.client = client
  }
  
  //MARK: Methods
  
  @MainActor
  func didFetchGamesFromGenre() async {
    guard !isLoadedData else { return }
    loaderState = .startLoading
    do {
      let dataGames = try await client.fetchList(genre)
      games = dataGames
      loaderState = .finishLoading
    } catch {
      //TODO show Empty state
      debugPrint("Error \(error)")
    }
    isLoadedData = true
  }
  
  //MARK: Private Methods
}
