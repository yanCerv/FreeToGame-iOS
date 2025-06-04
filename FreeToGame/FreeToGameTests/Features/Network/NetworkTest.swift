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
  var requestActor: RequestActor!
  var homeClient: HomeClientProvider!
  var detailClient: DetailClientProvider!
  var listGenreClient: ListGenreProvider!
  var response: [Game] = []
  var responseDetails: GameDetail?
  var errorHandler: ErrorHandler?
  var isSuccess: Bool = false
  var message: String = ""
  var statusCode: Int = 0
  
  @MainActor
  override func setUpWithError() throws {
    requestActor = RequestActor(serviceType: .mock, fileName: "GamesResponse")
    homeClient = HomeClient()
    listGenreClient = ListGenreClient()
    detailClient = DetailClientProviderTest()
  }
  
  override func tearDownWithError() throws {
    requestActor = nil
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
  
  func testRequestActor() async {
    XCTAssertNotNil(requestActor)
    
    do {
      let data = try await getDataTesting()
      XCTAssertFalse(data.isEmpty)
    } catch {
      XCTFail("Expected success, but got error: \(error)")
    }
  }
  
  private func getDataTesting() async throws -> [Game] {
    return try await requestActor.request(RequestConfiguration(path: "Test", method: .get))
  }
  
  @MainActor
  func testDetailClient() async {
    
    XCTAssertNotNil(detailClient)

    do {
      let data = try await detailClient.fetchDetail(by: 1)
      XCTAssertFalse(data.id == 0)
    } catch {
      XCTFail("Expected success, but got error: \(error)")
    }
  }
  
  @MainActor
  func testDetailFailure() async {
    detailClient = DetailClientProviderTest(responseType: .failure)
    XCTAssertNotNil(detailClient)

    do {
       _ = try await detailClient.fetchDetail(by: 1)
      XCTFail("Expected success, but got error")
    } catch {
      XCTAssertTrue(responseDetails == nil)
    }
  }
}
