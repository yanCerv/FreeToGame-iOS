//
//  NetworkTest.swift
//  FreeToGameTests
//
//  Created by Yan Cervantes on 01/12/24.
//

import XCTest
import Combine
@testable import FreeToGame

final class NetworkTest: XCTestCase {
  
  var homeClient: HomeClientProvider!
  var response: [Game] = []
  var errorHandler: ErrorHandler?
  var isSuccess: Bool = false
  var message: String = ""
  var statusCode: Int = 0
  
  override func setUpWithError() throws {
    homeClient = HomeClient()
  }
  
  override func tearDownWithError() throws {
    homeClient = nil
    response = []
    statusCode = 0
    message = ""
  }
  
  @MainActor
  func testClientWitchResponseSuccess() async {
    XCTAssertNotNil(homeClient)
    
    do {
      let response = try await homeClient.fetchDataGames()
      self.response = response
      XCTAssertFalse(response.isEmpty)
    } catch {
      XCTFail("Expected success, but got error: \(error)")
    }
  }
}
