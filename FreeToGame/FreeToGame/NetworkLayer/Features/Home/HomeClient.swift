//
//  HomeClient.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

import Combine

protocol HomeClientProvider {
  func fetchDataGames() async throws -> [Game]
}

actor HomeClient: Request, HomeClientProvider, AssistErrorMessage {
  
  private var anyCancellables: Set<AnyCancellable> = []
  
  var serviceType: ServiceType
  
  init(_ serviceType: ServiceType = .service) {
    self.serviceType = serviceType
  }
  
  func fetchDataGames() async throws -> [Game] {
    if serviceType == .mock {
      return await mockGames()
    } else {
      return try await withCheckedThrowingContinuation { continuation in
        Task {
          await gameServices().sink { completion in
            if let error = self.error(completion) {
              continuation.resume(throwing: error)
            }
          } receiveValue: { data in
            if data.isEmpty {
              continuation.resume(throwing: ErrorHandler.error(message: "No Games Found", statusCode: 1))
            } else {
              continuation.resume(returning: data)
            }
          }.store(in: &anyCancellables)
        }
      }
    }
  }
  
  private func gameServices() async -> AnyPublisher<[Game], ErrorHandler> {
    let config = HomeClientResources.getGames.config
    return await request(config)
  }
  
  //MARK: Mock Data
  
  private func mockGames() async -> [Game] {
    do {
      let response = try JsonResource.getFrom("GamesResponse", type: [Game].self)
      return response
    } catch {
      return []
    }
  }
}
