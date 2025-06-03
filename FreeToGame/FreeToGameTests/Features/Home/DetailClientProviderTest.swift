//
//  DetailClientProviderTest.swift
//  FreeToGameTests
//
//  Created by Yan Cervantes on 04/06/25.
//

@testable import FreeToGame

final class DetailClientProviderTest: DetailClientProvider {
  private var responseType: ResponseTypeTest
  private var errorHandler: ErrorHandler = .connection
  
  init(responseType: ResponseTypeTest = .success) {
    self.responseType = responseType
  }
  
  func fetchDetail(by gameId: Int) async throws -> GameDetail {
    switch responseType {
    case .failure:
      throw errorHandler
    case .success:
      do {
        let response = try JsonResource.getFrom("GameDetailMock", type: GameDetail.self)
        return response
      } catch {
        throw ErrorHandler.jsonConversionFail(message: "fail decoding data")
      }
    }
  }
}
