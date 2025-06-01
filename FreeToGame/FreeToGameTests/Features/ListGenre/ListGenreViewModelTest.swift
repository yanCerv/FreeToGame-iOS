//
//  ListGenreViewModelTest.swift
//  FreeToGameTests
//
//  Created by Yan Cervantes on 01/06/25.
//

import XCTest
@testable import FreeToGame

final class ListGenreViewModelTest: XCTestCase {
  var viewModel: ListGenreViewModel!
  var provider: HomeProviderTest!
  
  @MainActor
  override func setUp() async throws {
    provider = HomeProviderTest(responseType: .success)
    viewModel = ListGenreViewModel(provider)
  }
  
  override func tearDown() async throws {
    viewModel = nil
    provider = nil
  }
  
  @MainActor
  func testFetchGenresSuccess() async {
    // Al iniciar, géneros debe estar vacío
    XCTAssertTrue(viewModel.genres.isEmpty)
    XCTAssertFalse(viewModel.isLoadedData)
    
    await viewModel.fetchGames()
    
    XCTAssertTrue(viewModel.isLoadedData)
    XCTAssertEqual(viewModel.loaderState, .finishLoading)
    XCTAssertTrue(viewModel.errorMessage.isEmpty)
    
    let resultSet = Set(viewModel.genres)
    XCTAssertNotEqual(resultSet, [])
  }
  
  @MainActor
  func testFetchGenresError() async {
    // Configurar el provider para que falle con .connection
    provider.set(responseType: .failure, with: .connection)
    
    // Ejecutar fetchGames
    await viewModel.fetchGames()
    
    // Al fallar, no debe haber géneros cargados
    XCTAssertTrue(viewModel.isLoadedData)
    XCTAssertTrue(viewModel.genres.isEmpty)
    XCTAssertFalse(viewModel.errorMessage.isEmpty)
    XCTAssertEqual(viewModel.loaderState, .startLoading) // loaderState no se actualiza a finishLoading en caso de error
  }
}
