//
//  HomeViewModel.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/12/24.
//

import SwiftUI

@Observable
final class HomeViewModel {
  
  private let clientActor: HomeClientActor
  private let client: HomeClientProvider
  
  private(set) var loaderState: LoaderState = .finishLoading
  private(set) var categoryGames: [CategoryGames] = []
  private(set) var errorMessage: String = ""
  private(set) var showErrorAlert: Bool = false
  
  var isShowDetail: Bool = false
  var gameSelected: Game? = nil
    
  private var isLoadedData: Bool = false
  private let maxItemPerCategory: Int = 6

  //MARK: - Init
  
  @MainActor
  init(_ client: HomeClientProvider = HomeClient(), clientActor: HomeClientActor = .shared) {
    self.client = client
    self.clientActor = clientActor
  }
  
  //MARK: - Methods
  
  func didtapOn(_ game: Game) {
    gameSelected = game
    isShowDetail = true
  }
  
  @MainActor
  func fetchGames() async {
    guard !isLoadedData else { return }
    loaderState = .startLoading
    do {
   //   let games = try await clientActor.fetchDataGames()
      let games = try await client.fetchDataGames()
      categoryGames = configGamesCategory(games)
    } catch {
    //  errorMessage = handled(error)
      showErrorAlert = true
    }
    isLoadedData = true
    loaderState = .finishLoading
  }
  
  //MARK: - Private Methods
  
  private func configGamesCategory(_ games: [Game]) -> [CategoryGames] {
    let trendingGames = Array(games.prefix(maxItemPerCategory))
    let dateFormatter = DateFormatter.formatter(type: .fullDate)
    let newReleases = games
      .compactMap { game -> (Game, Date)? in
        guard let date = dateFormatter.date(from: game.releaseDate) else { return nil }
        return (game, date)
      }
      .sorted { $0.1 > $1.1 }
      .prefix(maxItemPerCategory)
      .map { $0.0 }
    
    let communityRecommendations = Array(games.shuffled().prefix(maxItemPerCategory))
    
    return [CategoryGames(title: "Trending Games", games: trendingGames),
            CategoryGames(title: "New Releases", games: newReleases),
            CategoryGames(title: "Recommendations", games: communityRecommendations)]
  }
}
