//
//  ListCategoriesViewModel.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import SwiftUI

@Observable
final class ListGenreViewModel: ShowErrorProtocol {
  private let client: HomeClientProvider!
  
  private(set) var genres: [String] = []
  private(set) var loaderState: LoaderState = .finishLoading
  private(set) var isLoadedData: Bool = false
  private(set) var errorMessage: String = ""
  
  //MARK: Init
  
  @MainActor
  init(_ client: HomeClientProvider = HomeClient()) {
    self.client = client
  }
  
  //MARK: Methods
  
  @MainActor
  func fetchGames() async {
    guard !isLoadedData else { return }
    loaderState = .startLoading
    do {
      let games = try await client.fetchDataGames()
      genres = configListGenre(games)
      loaderState = .finishLoading
    } catch {
      self.errorMessage = handled(error)
    }
    isLoadedData = true
  }
  
  //MARK: Private Methods
  
  private func configListGenre(_ games: [Game]) -> [String] {
    let categories: Set<String> = Set(games.map { $0.genre.trimmingCharacters(in: .whitespacesAndNewlines) })
    let listCategories = Array(categories)
    return listCategories
  }
}
