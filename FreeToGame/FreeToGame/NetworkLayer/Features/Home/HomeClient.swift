//
//  HomeClient.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 29/11/24.
//

import Combine

@MainActor
protocol HomeClientProvider {
  func fetchDataGames() async throws -> [Game]
}

@MainActor
final class HomeClient: Request, HomeClientProvider, AssistErrorMessage {
  
  private var anyCancellables: Set<AnyCancellable> = []
  
  var serviceType: ServiceType
  
  //MARK: Init
  
  init(_ serviceType: ServiceType = .service) {
    self.serviceType = serviceType
  }
  
  //MARK: Methods
  
  func fetchDataGames() async throws -> [Game] {
    if serviceType == .mock {
      return await mockGames()
    }
    
    return try await withCheckedThrowingContinuation { continuation in
      gameServices().sink { completion in
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
  
  private func gameServices() -> AnyPublisher<[Game], ErrorHandler> {
    let config = HomeClientResources.getGames.config
    return request(config)
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

// Actor Client

actor HomeClientActor {
  static let shared: HomeClientActor = HomeClientActor()
  
  private let requestActor: RequestActor
  private var serviceType: ServiceType
  
  init(_ requestActor: RequestActor = .shared, serviceType: ServiceType = .service) {
    self.requestActor = requestActor
    self.serviceType = serviceType
  }
  
  func fetchDataGames() async throws -> [Game] {
    if serviceType == .mock {
      return mockGames()
    } else {
      let configuration = HomeClientResources.getGames.config
      return try await requestActor.request(configuration)
    }
  }
  
  private func mockGames() -> [Game] {
    if let response = try? JsonResource.getFrom("GamesResponse", type: [Game].self) {
      return response
    }
    return []
  }
}
