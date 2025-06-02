//
//  HomeProviderTest.swift
//  FreeToGameTests
//
//  Created by Yan Cervantes on 02/12/24.
//

import Foundation
@testable import FreeToGame

final class HomeProviderTest: HomeClientProvider {
  private var responseType: ResponseTypeTest
  private var errorHandler: ErrorHandler = .connection
  
  init(responseType: ResponseTypeTest = .success) {
    self.responseType = responseType
  }
  
  func set(responseType: ResponseTypeTest, with errorHandler: ErrorHandler? = nil) {
    self.responseType = responseType
    
    if let errorHandler {
      self.errorHandler = errorHandler
    }
  }
  
  func fetchDataGames() async throws -> [Game] {
    switch responseType {
    case .failure:
      throw errorHandler
    case .success:
      do {
        let response = try JsonResource.getFrom("GamesResponse", type: [Game].self)
        return response
      } catch {
        throw ErrorHandler.jsonConversionFail(message: "fail decoding data")
      }
    }
  }
}
