//
//  HomeViewModel.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/12/24.
//

import SwiftUI

@Observable
final class HomeViewModel: ShowErrorProtocol {
  
  private let client: HomeClientProvider
  
  private(set) var loaderState: LoaderState = .finishLoading
  private(set) var categoryGames: [CategoryGames] = []
  private(set) var errorMessage: String = ""
  private(set) var showErrorAlert: Bool = false
    
  private var isLoadedData: Bool = false
  private let maxItemPerCategory: Int = 6

  //MARK: - Init
  
  @MainActor
  init(_ client: HomeClientProvider = HomeClient()) {
//  init(_ client: HomeClientProvider = HomeClient(.service)) {
    self.client = client
  }
  
  //MARK: - Methods
  
  @MainActor
  func fetchGames() async {
    guard !isLoadedData else { return }
    loaderState = .startLoading
    do {
      let games = try await client.fetchDataGames()
      categoryGames = configGamesCategory(games)
    } catch {
      errorMessage = handled(error)
      showErrorAlert = true
    }
    isLoadedData = true
    loaderState = .finishLoading
  }
  
  //MARK: - Private Methods
  
  private func configGamesCategory(_ games: [Game]) -> [CategoryGames] {
    let trendingGames = Array(games.prefix(maxItemPerCategory))
    let dateFormatter = DateFormatter.formatter(type: .fullDate)
    let newReleases = Array(games.sorted { guard let date1 = dateFormatter.date(from: $0.releaseDate),
                                                 let date2 = dateFormatter.date(from: $1.releaseDate) else { return false }
      return date1 > date2
    }.prefix(maxItemPerCategory))
    
    let communityRecommendations = Array(games.shuffled().prefix(maxItemPerCategory))
    
    return [CategoryGames(title: "Trending Games", games: trendingGames),
            CategoryGames(title: "New Releases", games: newReleases),
            CategoryGames(title: "Recommendations", games: communityRecommendations)]
  }
}
