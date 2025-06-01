//
//  ListSelectedGenreViewModelTest.swift
//  FreeToGameTests
//
//  Created by Yan Cervantes on 02/06/25.
//

import XCTest
@testable import FreeToGame

final class ListSelectedGenreViewModelTest: XCTestCase {
  var viewModel: SelectedGenreListViewModel!
  var mockProvider: SelectedGenreProviderTest!
  
  @MainActor
  override func setUp() async throws {
    mockProvider = SelectedGenreProviderTest(responseType: .success)
    viewModel = SelectedGenreListViewModel(genre: "Action", client: mockProvider)
  }
  
  override func tearDown() async throws {
    viewModel = nil
    mockProvider = nil
  }
  
  @MainActor
  func testFetchGamesFromGenreSuccess() async {
    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertTrue(viewModel.games.isEmpty)
    XCTAssertFalse(viewModel.isLoadedData)
    
    await viewModel.didFetchGamesFromGenre()
    
    XCTAssertTrue(!viewModel.genre.isEmpty)
    XCTAssertTrue(viewModel.isLoadedData)
    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertNotEqual(viewModel.games, [])
  }
  
  @MainActor
  func testFetchGamesFromGenreError() async {
    mockProvider.set(responseType: .failure, with: .connection)
    
    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertTrue(viewModel.games.isEmpty)
    XCTAssertFalse(viewModel.isLoadedData)
    
    await viewModel.didFetchGamesFromGenre()
    
    XCTAssertTrue(!viewModel.genre.isEmpty)
    XCTAssertTrue(viewModel.isLoadedData)
    XCTAssertEqual(viewModel.loaderState, .startLoading)
    XCTAssertTrue(viewModel.games.isEmpty)
  }
  
}
