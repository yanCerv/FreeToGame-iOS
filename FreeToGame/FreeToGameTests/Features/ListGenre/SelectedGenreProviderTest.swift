//
//  SelectedGenreProviderTest.swift
//  FreeToGameTests
//
//  Created by Yan Cervantes on 02/06/25.
//

import Foundation
@testable import FreeToGame

final class SelectedGenreProviderTest: ListGenreProvider {
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

    func fetchList(_ genre: String) async throws -> [Game] {
        switch responseType {
        case .failure:
            throw errorHandler
        case .success:
          do {
            let response = try JsonResource.getFrom("GenreListGamesMock", type: [Game].self)
            return response
          } catch {
            throw ErrorHandler.jsonConversionFail(message: "fail decoding data")
          }
        }
    }
}

