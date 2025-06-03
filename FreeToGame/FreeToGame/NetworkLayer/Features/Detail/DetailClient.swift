//
//  DetailClient.swift
//  FreeToGame
//
//  Created by Yan Cervantes on 03/06/25.
//

import Combine

@MainActor
protocol DetailClientProvider {
  func fetchDetail(by gameId: Int) async throws -> GameDetail
}

@MainActor
final class DetailClient: Request, DetailClientProvider, AssistErrorMessage {
  
  let serviceType: ServiceType
  var anyCancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  init(serviceType: ServiceType = .service) {
    self.serviceType = serviceType
  }
  
  func fetchDetail(by gameId: Int) async throws -> GameDetail {
    if serviceType == .mock,
    let mockData = getMock() {
      return mockData
    }
    
    return try await withCheckedThrowingContinuation { continuation in
      getDetail(by: gameId).sink { completion in
        if let error = self.error(completion) {
          continuation.resume(throwing: error)
        }
      } receiveValue: { response in
        continuation.resume(returning: response)
      }.store(in: &anyCancellables)
    }
  }
  
  private func getDetail(by gameId: Int) -> AnyPublisher<GameDetail, ErrorHandler> {
    let config = DetailClientResource.detail(gameId: gameId).config
    return request(config)
  }
  
  private func getMock() -> GameDetail? {
    do {
      let response = try JsonResource.getFrom("GamesDetailMock", type: GameDetail.self)
      return response
    } catch {
      return nil
    }
  }
}
