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
  var listGenreClient: ListGenreProvider!
  var response: [Game] = []
  var errorHandler: ErrorHandler?
  var isSuccess: Bool = false
  var message: String = ""
  var statusCode: Int = 0
  
  @MainActor
  override func setUpWithError() throws {
    homeClient = HomeClient()
    listGenreClient = ListGenreClient()
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
  
  @MainActor
  func testGenreClientWitchResponseSuccess() async {
    XCTAssertNotNil(listGenreClient)
    
    do {
      let response = try await listGenreClient.fetchList("action")
      XCTAssertFalse(response.isEmpty)
    } catch {
      XCTFail("Expected success, but got error: \(error)")
    }
  }
}
