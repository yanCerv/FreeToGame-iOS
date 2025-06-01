//
//  ListGenreClient.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 01/06/25.
//

import Combine

@MainActor
protocol ListGenreProvider {
  func fetchList(_ genre: String) async throws -> [Game]
}

@MainActor
final class ListGenreClient: Request, ListGenreProvider, AssistErrorMessage {
  
  private var anyCancellables: Set<AnyCancellable> = []
  
  var serviceType: ServiceType
  
  //MARK: Init
  
  init(_ serviceType: ServiceType = .service) {
    self.serviceType = serviceType
  }
  
  //MARK: Methods
  
  func fetchList(_ genre: String) async throws -> [Game] {
    if serviceType == .mock {
      return await mockGames()
    }
    
    return try await withCheckedThrowingContinuation { continuation in
      gameServices(genre).sink { completion in
        if let error = self.error(completion) {
          continuation.resume(throwing: error)
        }
      } receiveValue: { response in
        if response.isEmpty {
          continuation.resume(throwing: ErrorHandler.error(message: "No Games Found", statusCode: 1))
        } else {
          continuation.resume(returning: response)
        }
      }.store(in: &anyCancellables)
    }
  }
  
  private func gameServices(_ genre: String) -> AnyPublisher<[Game], ErrorHandler> {
    let config = ListGenreResource.getgames(genre: genre).config
    return request(config)
  }
  
  //MARK: Mock Data
  
  private func mockGames() async -> [Game] {
    do {
      let response = try JsonResource.getFrom("GenreListGamesMock", type: [Game].self)
      return response
    } catch {
      return []
    }
  }
}
