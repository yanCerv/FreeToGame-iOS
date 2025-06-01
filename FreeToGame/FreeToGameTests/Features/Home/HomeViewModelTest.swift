//
//  HomeViewModelTest.swift
//  FreeToGameTests
//
//  Created by Yan Cervantes on 02/12/24.
//

import XCTest
@testable import FreeToGame

final class HomeViewModelTest: XCTestCase {
  
  var homeProvider: HomeProviderTest!
  var viewModel: HomeViewModel!

  @MainActor
  override func setUpWithError() throws {
    homeProvider = HomeProviderTest()
    viewModel = HomeViewModel(homeProvider)
  }
  
  override func tearDownWithError() throws {
    viewModel = nil
    homeProvider = nil
  }
  
  @MainActor
  func testServiceDataWithSuccess() async {
    XCTAssertNotNil(viewModel)
    XCTAssertNotNil(homeProvider)
    await viewModel.fetchGames()

    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertFalse(viewModel.categoryGames.isEmpty)
    XCTAssertTrue(viewModel.errorMessage.isEmpty)
    XCTAssertFalse(viewModel.showErrorAlert)
  }
  
  @MainActor
  func testServiceDataWithRequestError() async {
    XCTAssertNotNil(viewModel)
    XCTAssertNotNil(homeProvider)
    
    await homeProvider.set(responseType: .failure, with: .requestFail)
    await viewModel.fetchGames()
    
    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertTrue(viewModel.categoryGames.isEmpty)
    XCTAssertFalse(viewModel.errorMessage.isEmpty)
    XCTAssertTrue(viewModel.showErrorAlert)
  }
  
  @MainActor
  func testServiceDataWithConnectionError() async {
    XCTAssertNotNil(viewModel)
    XCTAssertNotNil(homeProvider)

    await homeProvider.set(responseType: .failure, with: .connection)
    await viewModel.fetchGames()

    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertTrue(viewModel.categoryGames.isEmpty)
    XCTAssertFalse(viewModel.errorMessage.isEmpty)
    XCTAssertTrue(viewModel.showErrorAlert)
  }
  
  @MainActor
  func testServiceDataWithJsonConversionError() async {
    XCTAssertNotNil(viewModel)
    XCTAssertNotNil(homeProvider)

    await homeProvider.set(responseType: .failure, with: .jsonConversionFail(message: "test error json"))
    await viewModel.fetchGames()
    
    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertTrue(viewModel.categoryGames.isEmpty)
    XCTAssertFalse(viewModel.errorMessage.isEmpty)
    XCTAssertTrue(viewModel.showErrorAlert)
  }
  
  @MainActor
  func testServiceDataWithErrorContent() async {
    XCTAssertNotNil(viewModel)
    XCTAssertNotNil(homeProvider)

    await homeProvider.set(responseType: .failure, with: .error(message: "test error content", statusCode: 1))
    await viewModel.fetchGames()
        
    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertTrue(viewModel.categoryGames.isEmpty)
    XCTAssertFalse(viewModel.errorMessage.isEmpty)
    XCTAssertTrue(viewModel.showErrorAlert)
  }
}
